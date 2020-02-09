source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'aws-sdk-rails'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'carrierwave'
gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'dotenv-rails'
gem 'exifr'
gem 'faker'
gem 'fog-aws'
gem 'jbuilder', '~> 2.7'
gem 'kaminari'
gem 'mini_magick'
gem 'mysql2'
gem 'pry-rails'
gem 'puma', '~> 4.3'
gem 'rails', '~> 6.0.1'
gem 'ransack'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'
gem 'sitemap_generator'
gem 'whenever', require: false
gem 'geocoder'

group :development, :test do
  gem 'bcrypt_pbkdf'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano3-puma', require: false
  gem 'capistrano-rails-console'
  gem 'ed25519'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rails'
end

group :development do
  gem 'foreman'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
  gem 'rack-mini-profiler', require: false
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'rspec_junit_formatter'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production do
  gem 'fog', '1.42'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]