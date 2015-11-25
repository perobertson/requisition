namespace :project do
  desc 'Sets up the project by creating a file you can source to customize the environment'
  task :setup do
    unless Rails.env.development?
      abort 'This task is only to be run in development.'.red
    end

    unless Dir.exist?(File.join(Dir.home, '.projects'))
      Dir.mkdir(File.join(Dir.home, '.projects'), 0700)
    end

    unless File.exist?(File.join(Dir.home, '.projects/requisition'))

      cmd = 'whoami'
      user_name = `#{cmd}`

      File.open File.join(Dir.home, '.projects/requisition'), 'w' do |file|
        # For Postgres
        file.write "export REQUISITION_PG_USERNAME=#{user_name}"

        # For Mailers
        file.write "export MAILER_DOMAIN=\n"
        file.write "export MAILER_HOST=\n"
        file.write "export MAILER_FROM_EMAIL=\n"
        file.write "export SPARKPOST_SMTP_HOST=\n"
        file.write "export SPARKPOST_SMTP_PORT=\n"
        file.write "export SPARKPOST_SMTP_USERNAME=\n"
        file.write "export SPARKPOST_SMTP_PASSWORD=\n"

        # For the project
        file.write "export REQUISITION_BUILDER_EMAIL=\n"
      end
    end

    puts "cat '~/.projects/requisition'".yellow
    puts `cat ~/.projects/requisition`
    puts "\n"
  end
end
