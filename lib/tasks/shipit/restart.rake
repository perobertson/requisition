require 'rake'
require 'heroku_helper'
require 'colorize'

namespace :shipit do
  task :restart do
    Rake::Task["shipit:restart:#{ENV['ENVIRONMENT']}"].invoke
  end
  namespace :restart do
    desc 'Restart production'
    task :production do
      restart 'space-dolphins'
    end

    desc 'Restart staging'
    task :staging do
      restart 'space-dolphins-staging'
    end

    def restart app_name
      key = ENV['HEROKU_API_KEY']
      abort 'HEROKU_API_KEY is required'.red if key.blank?

      app = HerokuHelper::App.new(key, app_name)
      app.restart
    end
  end
end
