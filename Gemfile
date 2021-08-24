source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

## BASE
gem 'rails', '~> 6.1.4'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem "image_processing", ">= 1.2"

## AJOUT PERSONNEL
gem 'boring_generators'
gem "devise", "~> 4.8"
gem "omniauth"
gem "omniauth-github"
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection"
gem 'acts_as_votable'
gem 'pagy'
gem 'faker'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]