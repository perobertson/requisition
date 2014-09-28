namespace :project do
  task :setup do
    unless Dir.exists?(File.join(Dir.home, ".projects"))
      Dir.mkdir(File.join(Dir.home, ".projects"), 0700)
    end

    unless File.exists?(File.join(Dir.home, ".projects/requisition"))
      File.open File.join(Dir.home, ".projects/requisition"), "w" do |file|
        file.write "export REQUISITION_PG_USERNAME=\n"
        file.write "export REQUISITION_PG_PASSWORD=\n"
        file.write "export REQUISITION_BUILDER_EMAIL=\n"
        file.write "export REQUISITION_MAILER_ACCOUNT=\n"
        file.write "export REQUISITION_MANDRILL_USERNAME=\n"
        file.write "export REQUISITION_MANDRILL_APIKEY=\n"
        file.write "export REQUISITION_MAILER_DOMAIN=\n"
        file.write "export REQUISITION_MAILER_HOST=\n"
      end
    end
  end
end
