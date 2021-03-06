source 'https://rubygems.org'
ruby '2.2.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use mysql as the database for Active Record
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails'
gem 'bourbon' # http://bourbon.io/
gem 'neat' # http://neat.bourbon.io/
gem 'refills'
gem 'compass-rails'
gem 'nprogress-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
gem 'slim-rails'

gem 'browserify-rails', '~> 0.7'
gem 'js-routes'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'rails-api'
gem 'twitter'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'
gem 'puma'
gem 'foreman'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# error handring
gem 'rambulance'

# request session (https://github.com/steveklabnik/request_store)
gem 'request_store'

# simple http client (https://github.com/httprb/http.rb)
gem 'http'

# push notification
# http://qiita.com/sue738/items/c2ce141cf24f9f1dbf01
# gem 'apns'
# gem 'gcm'

# In App Purchase
gem 'venice'

# heroku variable manager
gem 'figaro'

gem 'kaminari'

gem 'newrelic_rpm'
gem 'bootstrap-sass'
gem 'autoprefixer-rails'

gem 'config'

gem 'draper'
gem 'cells'
gem 'enumerize'
gem 'active_hash'
# https://github.com/activerecord-hackery/squeel
# gem 'squeel'

gem 'nokogiri'

# Ope
gem 'activeadmin', github: 'activeadmin'
gem 'just-datetime-picker'
gem 'devise'
gem 'cancancan'
gem 'aws-sdk-core'
gem 'rmagick', '2.13.2', require: 'RMagick'

gem 'rails_12factor', group: :production

gem 'yaml_db'
gem 'httpclient'
gem 'peek'
gem 'woothee'

gem 'whenever', require: false

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rb-readline'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'rspec-rails'
  gem 'guard-rspec', require: false
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'childprocess'

  gem 'rubocop'
  gem 'bugspots'     # https://github.com/igrigorik/bugspots
  gem 'did_you_mean' # http://qiita.com/yuki24/items/feb72ee1f280434d5a5f

  # https://www.infinum.co/the-capsized-eight/articles/top-8-tools-for-ruby-on-rails-code-optimization-and-cleanup
  gem 'traceroute'
  # gem 'rack-mini-profiler'
  # gem 'brakeman', :require => false
  gem 'rails_best_practices'
  gem 'rubycritic', require: false

  # http://logictkt.hatenablog.com/entry/2014/10/09/210737
  gem 'awesome_print'
  gem 'annotate'
  gem 'squasher' # unify migration files (https://github.com/jalkoby/squasher)
  gem 'rails-erd'
  gem 'letter_opener_web'
  gem 'better_errors'

  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'gimei'

  gem 'bundler-auto-update'
end

group :development do
  gem 'pry-rails'
  gem 'quiet_assets'
  gem 'meta_request'
  gem 'bullet'
  gem 'activerecord-cause'
end

group :test do
  gem 'selenium-webdriver'
  gem 'capybara'
  gem 'turnip'

  gem 'colored'
  gem 'deadweight', require: 'deadweight/hijack/rails'
  gem 'test-unit'
  # gem 'test-unit-full'
end
