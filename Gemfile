source 'https://rubygems.org'

ruby '2.3.0'

gem 'rails', github: 'rails/rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', github: 'rails/coffee-rails'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'faker'
gem 'money-rails'

# Use Puma as the app server
gem 'puma'
gem 'counter_culture'
gem 'kaminari', github: 'amatsuda/kaminari'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'simple_form'
gem 'cocoon'
gem 'dalli'
gem 'connection_pool'
gem 'active_model_serializers', github: 'rails-api/active_model_serializers'
gem 'rails_12factor', group: :production
gem 'react-rails', '~> 1.6.0'
gem 'rack-cors', :require => 'rack/cors'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'pry-byebug'
  gem 'factory_girl_rails'
  gem 'rails-controller-testing'

  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, :git => "https://github.com/rspec/#{lib}.git", :branch => 'master'
  end
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', github: 'rails/web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'annotate'
  gem 'pry-rails'
  gem 'bullet'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'sextant' # go to /rails/routes
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
