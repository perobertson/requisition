# frozen_string_literal: true

source 'https://rubygems.org'

# language and framework version
ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2', group: %i[default deploy]

group :production do
  # For heroku logging and static assets
  gem 'rails_12factor', '~> 0.0.3'
  # App stats
  gem 'newrelic_rpm', '~> 5.7'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.0.2'

  gem 'guard', '~> 2.15.0'
  gem 'guard-minitest', '~> 2.4.6'
end

group :development, :test do
  # Lets you go back and forth in time virtually
  gem 'timecop', '~> 0.9.1'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 10.0.2'
  # Trust me, better errors
  gem 'better_errors', '~> 2.5.1'
  # Debug console on error page
  gem 'binding_of_caller', '~> 0.8.0'
  # For finding security vulnerabilities
  gem 'brakeman', '~> 4.4.0'
  # Gives you spec syntax like Rspec but for minitest
  gem 'minitest-spec-rails', '~> 5.5.0'
  # For custom environment variables
  gem 'dotenv-rails', '~> 2.6.0'
end

group :test do
  gem 'minitest', '~> 5.11.3'
  # Code coverage for Ruby 1.9+ with a powerful configuration library
  # and automatic merging of coverage across test suites
  gem 'simplecov', '~> 0.16.1'
  # For test status
  gem 'minitest-ci', '~> 3.4.0'
  # Static analysis against the ruby style guide
  gem 'rubocop', '< 1.0'
end

group :default, :deploy do
  gem 'dpl-heroku', '~> 1.10.7', require: false
end

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Error reporting
gem 'rollbar', '~> 2.18.2'
# For killing long running connections
gem 'rack-timeout', '~> 0.5.1'

# Puma web server
gem 'puma', '~> 3.12.0'

# Auth
gem 'devise', '~> 4.0'
gem 'omniauth-eveonline', '~> 1.0.1'
gem 'pundit', '~> 1.1.0'

# Logging add-on that compresses Rails multi-line output
# so that it doesn't get mixed up with other requests in parallel
gem 'lograge', '~> 0.10.0'
# Postgres database
gem 'pg', '~> 1.1.4'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', '~> 0.12.3', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.3.3'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 5.2'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.8'

# For getting controller data into the js
gem 'gon', '~> 6.2.1'
# gives us the SASS version of bootstrap
gem 'bootstrap-sass', '~> 3.4.1'
# a switch component for bootstrap
gem 'bootstrap-switch-rails', '~> 3.3.4'
