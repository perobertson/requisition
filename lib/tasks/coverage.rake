namespace :coverage do
  task :notify do
    unless Rails.env.test?
      puts 'This task is only to be run in test.'
      next # Exit early
    end

    json = {
      payload: {
        build_num: ENV['CIRCLE_BUILD_NUM'].to_i,
        status: 'done'
      }
    }.to_json

    cmd = "curl -H 'Content-Type: application/json' -d '#{json}' https://coveralls.io/webhook?repo_token=#{ENV['COVERALLS_REPO_TOKEN']}"
    puts cmd

    result = `#{cmd}`
    puts result
  end
end
