namespace :project do
  task :setup do
    unless Rails.env.development?
      puts "This task is only to be run in development."
      next # Exit early
    end

    unless Dir.exists?(File.join(Dir.home, ".projects"))
      Dir.mkdir(File.join(Dir.home, ".projects"), 0700)
    end

    unless File.exists?(File.join(Dir.home, ".projects/requisition"))

      cmd = "whoami"
      user_name = `#{cmd}`

      File.open File.join(Dir.home, ".projects/requisition"), "w" do |file|
        # For Postgres
        file.write "export REQUISITION_PG_USERNAME=#{user_name}"

        # For Mandril
        file.write "export REQUISITION_MAILER_ACCOUNT=\n"
        file.write "export REQUISITION_MANDRILL_USERNAME=\n"
        file.write "export REQUISITION_MANDRILL_APIKEY=\n"
        file.write "export REQUISITION_MAILER_DOMAIN=\n"
        file.write "export REQUISITION_MAILER_HOST=\n"
        
        # For the project
        file.write "export REQUISITION_BUILDER_EMAIL=\n"
      end
    end

    puts "cat '~/.projects/requisition'"
    puts `cat ~/.projects/requisition`
    puts "\n"
  end
end