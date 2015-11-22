require 'rake'
require 'heroku_helper'
require 'colorize'

namespace :shipit do
  task :version do
    Rake::Task["shipit:version:#{ENV['ENVIRONMENT']}"].invoke
  end
  namespace :version do
    desc 'Fetch production version'
    task :production do
      puts version 'space-dolphins'
    end

    desc 'Fetch staging version'
    task :staging do
      puts version 'space-dolphins-staging'
    end

    def version app_name
      key = ENV['HEROKU_API_KEY']
      abort 'HEROKU_API_KEY is required'.red if key.blank?

      app = HerokuHelper::App.new(key, app_name)
      app.version
    end
  end
end
