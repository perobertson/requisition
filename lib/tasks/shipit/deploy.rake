require 'rake'
require 'platform-api'
require 'rendezvous'
require 'colorize'

namespace :shipit do
  task :deploy do
    Rake::Task["shipit:deploy:#{ENV['ENVIRONMENT']}"].invoke
  end
  namespace :deploy do
    desc 'Deploys staging'
    task :staging do
      deploy ENV['APP_STAGING'], 'staging'
    end

    def deploy app_name, remote_name
      heroku = PlatformAPI.connect_oauth ENV['HEROKU_API_KEY']
      git_url = heroku.app.info(app_name)['git_url']
      if git_url.blank?
        abort 'Could not find repo to push to'.red
      end
      `git remote rm #{remote_name}`
      `git remote add #{remote_name} #{git_url}`
      `git fetch #{remote_name}`

      pending = `git diff --name-only HEAD..#{remote_name}/master | grep db/migrate` != ''

      unless maintenance heroku, app_name, true
        abort 'enabling maintenance failed'.red
      end

      `git push #{remote_name} HEAD:master`

      if pending
        migrate heroku, app_name
      else
        puts 'No migrations'.green
      end

      heroku.dyno.restart_all app_name

      unless maintenance heroku, app_name, false
        abort 'disabling maintenance failed'.red
      end

      puts 'Work Complete!!!'.green
    end

    def maintenance heroku, app_name, enabled
      payload = {
        maintenance: enabled
      }
      response = heroku.app.update(app_name, payload)
      response['maintenance'] == enabled
    end

    def migrate heroku, app_name
      payload = {
        attach: true,
        command: 'rake db:migrate'
      }
      response = heroku.dyno.create(app_name, payload)
      begin
        # set an activity timeout so it doesn't block forever
        Rendezvous.start(url: response['attach_url'], activity_timeout: 600)
      rescue => e
        log.error("Error capturing output for dyno\n#{e.message}")
      end
    end
  end
end
