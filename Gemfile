source 'https://rubygems.org'

# language and framework version
ruby '2.2.3'
gem 'rails', '4.2.4', group: [:default, :deploy]

group :production do
  # For heroku logging and static assets
  gem 'rails_12factor'
  # App stats
  gem 'newrelic_rpm'
  # Error reporting
  gem 'rollbar'
  # For killing long running connections
  gem 'rack-timeout'
end

group :development do
  # Add consoles to pages for debugging
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  # Lets you go back and forth in time virtually
  gem 'timecop'
  # Byebug is a simple to use, feature rich debugger for Ruby 2
  gem 'byebug'
  # Trust me, better errors
  gem 'better_errors'
  # Debug console on error page
  gem 'binding_of_caller'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Squelch the logging of asset retrieval
  gem 'quiet_assets'
  # For finding security vulnerabilities
  gem 'brakeman'
  # Gives you spec syntax like Rspec but for minitest
  gem 'minitest-spec-rails'
  # For custom environment variables
  gem 'dotenv-rails'
end

group :test do
  # Code coverage for Ruby 1.9+ with a powerful configuration library
  # and automatic merging of coverage across test suites
  gem 'simplecov'
  # for other reporters
  gem 'minitest-reporters'
  # JS engine for testing
  gem 'therubyracer',  platforms: :ruby
  # For test status
  gem 'minitest-ci', git: 'git@github.com:circleci/minitest-ci.git'
  # For code coverage
  gem 'coveralls'
  # Static analysis against the ruby style guide
  gem 'rubocop'
end

group :deploy do
  # A wrapper library around the heroku platform api for easy app management
  gem 'heroku-platform-helper', require: false
end

# Colorize the terminal
gem 'colorize', require: false, group: [:default, :deploy]

# Puma web server
gem 'puma'

# Auth
gem 'devise'
gem 'omniauth-eveonline'

# Mailer
gem 'mandrill-api'
# Logging add-on that compresses Rails multi-line output
# so that it doesn't get mixed up with other requests in parallel
gem 'lograge'
# Postgres database
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use YUI as compressor for JavaScript assets
gem 'yui-compressor'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.2'

# For getting controller data into the js
gem 'gon'
# gives us the SASS version of bootstrap
gem 'bootstrap-sass'
# a switch component for bootstrap
gem 'bootstrap-switch-rails'

