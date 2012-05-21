source 'http://rubygems.org'

gem 'rails', '3.1.0.rc8'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'mysql2'

gem "execjs"
gem "therubyracer"
gem 'sorcery'

gem 'will_paginate','3.0.2'
gem "paperclip", "~> 2.3"
#gem "s3", :git => "git://github.com/qoobaa/s3.git"
gem 'aws-s3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0.rc"
  gem 'coffee-rails', "~> 3.1.0.rc"
  gem 'uglifier'
end

gem 'jquery-rails'
gem "activemerchant", :git=> "git://github.com/Shopify/active_merchant.git"

group :production do
  # gems specifically for Heroku go here
  gem "pg"
end


# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
#  gem 'rspec-rails', '2.6.1'
  gem 'rspec-rails', '2.10.0'
  gem 'annotate', '2.4.0'
  gem 'sqlite3'
end

group :test do
  # Pretty printed test output
  # gem 'turn', :require => false
 # gem 'rspec-rails', '2.6.1'
  gem 'rspec-rails', '2.10.0'
  gem 'webrat', '0.7.1'
  gem 'spork', '0.9.0.rc8'
  
end
