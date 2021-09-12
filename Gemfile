# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

## BASE
gem 'bootsnap', '>= 1.4.4', require: false
gem 'image_processing', '>= 1.2'
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

## AJOUT PERSONNEL
gem 'actiontext', '~> 6.1', '>= 6.1.4.1'
gem 'active_storage_validations'
gem 'acts_as_votable'
gem 'boring_generators'
gem 'devise', '~> 4.8'
gem 'devise_invitable'
gem 'faker'
gem 'invisible_captcha'
gem 'letter_opener', group: :development
gem 'mini_magick'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'omniauth-twitter'
gem 'pagy'
gem 'pundit'
gem 'rolify'
gem 'friendly_id', '~> 5.4', '>= 5.4.2'
gem 'public_activity'
gem 'stripe'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'web-console', '>= 4.1.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
