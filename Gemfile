# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# language and framework version
ruby '2.5.7'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4', group: %i[default deploy]

group :production do
  # For heroku logging and static assets
  gem 'rails_12factor', '~> 0.0.3'
  # App stats
  gem 'newrelic_rpm', '~> 5.7'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.1.0'

  gem 'guard', '~> 2.16.1'
  gem 'guard-minitest', '~> 2.4.6'
end

group :development, :test do
  # Lets you go back and forth in time virtually
  gem 'timecop', '~> 0.9.1'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 11.1.1'
  # Trust me, better errors
  gem 'better_errors', '~> 2.5.1'
  # Debug console on error page
  gem 'binding_of_caller', '~> 0.8.0'
  # For finding security vulnerabilities
  gem 'brakeman', '~> 4.5.1'
  # Gives you spec syntax like Rspec but for minitest
  gem 'minitest-spec-rails', '~> 6.0.2'
  # For custom environment variables
  gem 'dotenv-rails', '~> 2.7.5'
end

group :test do
  gem 'minitest', '~> 5.14.0'
  # Code coverage for Ruby 1.9+ with a powerful configuration library
  # and automatic merging of coverage across test suites
  gem 'simplecov', '~> 0.18.5'
  # For test status
  gem 'minitest-ci', '~> 3.4.0'
  # Static analysis against the ruby style guide
  gem 'rubocop', '< 1.0'
  gem 'rubocop-rails', '~> 2.4'
end

group :default, :deploy do
  gem 'dpl-heroku', '~> 1.10.15', require: false
end

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Error reporting
gem 'rollbar', '~> 2.24.0'
# For killing long running connections
gem 'rack-timeout', '~> 0.6.0'

# Puma web server
gem 'puma', '~> 3.12.4'

# Auth
gem 'devise', '~> 4.7'
gem 'omniauth-eveonline', '~> 1.0.1'
gem 'pundit', '~> 2.1.0'

# Logging add-on that compresses Rails multi-line output
# so that it doesn't get mixed up with other requests in parallel
gem 'lograge', '~> 0.11.2'
# Postgres database
gem 'pg', '~> 1.2.2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 5.0.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.3.5'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 5.2'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.10'

# For getting controller data into the js
gem 'gon', '~> 6.3.2'
# gives us the SASS version of bootstrap
gem 'bootstrap-sass', '~> 3.4.1'
# a switch component for bootstrap
gem 'bootstrap-switch-rails', '~> 3.3.5'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
