source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Core Rails Framework
gem "rails", "~> 7.1.3"

# Database
gem "pg", "~> 1.5"

# Security & Authentication
gem "bcrypt", "~> 3.1.7"
gem "devise", "~> 4.9"
gem "pundit", "~> 2.3"

# Performance & Background Processing
gem "puma", "~> 6.0"
gem "sidekiq", "~> 7.2"

# Hotwire ecosystem for modern reactive UI
gem "turbo-rails", "~> 2.0"
gem "stimulus-rails", "~> 1.3"

# Assets & UI Styling
gem "cssbundling-rails", "~> 1.4"
gem "jsbundling-rails", "~> 1.3"
gem "jbuilder", "~> 2.11"

# Utilities
gem "kaminari", "~> 1.2" # Pagination
gem "prawn", "~> 2.4"   # PDF Payslip Generation

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x86_mingw cygwin ucrt ]
  gem "byebug"
  gem "rspec-rails", "~> 6.1"
  gem "factory_bot_rails", "~> 6.4"
  gem "faker", "~> 3.2"
end

group :development do
  gem "web-console"
end
