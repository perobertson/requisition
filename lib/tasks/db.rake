require 'colorize'

namespace :db do
  desc 'Fully resets the database and loads the fixtures'
  task nuke: :environment do
    unless Rails.env.development?
      abort 'This task is only to be run in development.'.red
    end

    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['test:prepare'].invoke
    Rake::Task['cache:clear'].invoke

    # Hack for forcing the fixtures to load
    system 'bundle exec rake db:fixtures:load'

    puts 'Ready to go'.green
  end
end
