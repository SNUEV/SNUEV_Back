source 'https://rubygems.org'
ruby '2.4.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'impressionist'
gem 'kaminari'
gem 'rack-cors'
gem 'bcrypt'
gem 'jwt'
gem 'cancancan', '~> 2.0'
gem 'jsonapi-rails'
gem 'newrelic_rpm'
gem 'sentry-raven'
gem 'chewy'
gem 'friendly_id', '~> 5.1.0'
gem 'roo'
gem 'roo-xls'
gem 'dotenv-rails'

group :development, :test do
  gem 'mina', require: false
  gem 'mina-puma', require: false
  gem 'rspec-rails', '~> 3.6'
  gem 'rails-controller-testing'
  gem 'webmock'
  gem 'factory_bot_rails'
  gem 'database_cleaner'
  gem 'guard', require: false
  gem 'guard-rspec', require: false
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'simplecov', require: false
end
