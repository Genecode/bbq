source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '>=2.5.1'

gem 'rails', '~> 5.2.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
#gem 'bootsnap'
gem 'listen'
gem 'twitter-bootstrap-rails'
gem 'font-awesome-rails'
gem 'carrierwave'
gem 'rmagick'
gem 'fog-aws'

gem 'turbolinks', '~> 5'
gem 'omniauth'
gem 'omniauth-vkontakte'

gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n', '~> 5.1'

group :development, :test do
  gem 'capistrano', "~> 3.11", require: false
  gem 'capistrano-rails', "~> 1.3", require: false
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
end

group :production do
  gem 'pg'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
