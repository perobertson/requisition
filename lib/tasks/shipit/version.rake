# frozen_string_literal: true
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

    def version(app_name)
      key = ENV['HEROKU_API_KEY']
      abort 'HEROKU_API_KEY is required'.red if key.blank?

      # Silence any logs so shipit can fetch the version
      initial = HerokuHelper.logger
      HerokuHelper.logger = Logger.new('/dev/null')

      begin
        app = HerokuHelper::App.new(key, app_name)
        return app.version
      ensure
        HerokuHelper.logger = initial
      end
    end
  end
end
