source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "2.7.1"

gem "autoprefixer-rails"
gem "bootsnap", require: false
gem 'graphql'
gem "pg"
gem "puma"
gem "rack-canonical-host"
gem "rails", "~> 6.0.0"
gem "recipient_interceptor"
gem "sassc-rails"
gem "sprockets", "< 4"
gem "tzinfo-data", platforms: [:mingw, :x64_mingw, :mswin, :jruby]
gem "webpacker"

group :development do
  gem "listen"
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "pry-byebug"
  gem "pry-rails"
end

group :test do
  gem "formulaic"
  gem "launchy"
  gem "timecop"
  gem "webmock"
end

gem "suspenders", group: [:development, :test]
gem 'rack-mini-profiler', require: false
gem 'oj'
gem 'high_voltage'
gem 'spring-commands-rspec', group: :development
gem 'rspec-rails', '~> 3.6', group: [:development, :test]
gem 'shoulda-matchers', group: :test
gem 'webdrivers', group: :test
gem 'bullet', group: [:development, :test]
gem 'factory_bot_rails', group: [:development, :test]
gem 'inline_svg'
gem 'bundler-audit', '>= 0.7.0', require: false, group: [:development, :test]
gem 'rack-timeout', group: :production

gem 'graphiql-rails', group: :development
