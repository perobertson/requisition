source 'https://rubygems.org'


# language and framework version
ruby '2.1.2'
gem 'rails', '4.1.4'

group :production do
  # For heroku logging and static assets
  gem 'rails_12factor'
  # Unicorn web server
  gem 'unicorn'
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
  # Thin web server
  gem 'thin'
  # Squelch the logging of asset retrieval
  gem 'quiet_assets'
  # For finding security vulnerabilities
  gem 'brakeman'
end

group :test do
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Logging add-on that compresses Rails multi-line output
# so that it doesn't get mixed up with other requests in parallel
gem 'lograge'
# Postgres database
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# For getting controller data into the js
gem 'gon'
# gives us the SASS version of bootstrap
gem 'bootstrap-sass'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
