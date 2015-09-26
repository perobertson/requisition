require 'rake'
require 'platform-api'

namespace :shipit do
  task :restart do
    Rake::Task["shipit:restart:#{ENV['ENVIRONMENT']}"].invoke
  end
  namespace :restart do
    desc 'Restart production'
    task :production do
      puts restart ENV['APP_PRODUCTION']
    end

    desc 'Restart staging'
    task :staging do
      puts restart ENV['APP_STAGING']
    end

    def restart app_name
      heroku = PlatformAPI.connect_oauth ENV['HEROKU_API_KEY']
      heroku.dyno.restart_all app_name
    end
  end
end
