source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.0"

# Core Rails Framework
gem "rails", "~> 7.1.3"

# Database & Storage
gem "pg", "~> 1.5"

# Security & Authentication
gem "bcrypt", "~> 3.1.20"
gem "devise", "~> 4.9"
gem "pundit", "~> 2.3"

# Performance, Real-Time WebSockets & Background Processing
gem "puma", "~> 6.5"
gem "sidekiq", "~> 7.3"
gem "redis", "~> 5.2"

# Hotwire Ecosystem for Reactive UI
gem "turbo-rails", "~> 2.0"
gem "stimulus-rails", "~> 1.3"

# Assets & UI Styling
gem "cssbundling-rails", "~> 1.4"
gem "jsbundling-rails", "~> 1.3"
gem "jbuilder", "~> 2.11"

# Document & Report Generation
gem "kaminari", "~> 1.2" # Pagination
gem "prawn", "~> 2.5"   # PDF Payslip Generation
gem "nokogiri", "~> 1.16" # ISO20022 SEPA Bank XML Export

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x86_mingw cygwin ucrt ]
  gem "byebug"
  gem "rspec-rails", "~> 6.1"
  gem "factory_bot_rails", "~> 6.4"
  gem "faker", "~> 3.3"
end

group :development do
  gem "web-console"
end
