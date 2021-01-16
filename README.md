![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a) ![](https://img.shields.io/badge/Ruby-2.5.3-orange)

# Sweater Weather

## About This Project:

## Table of Contents
* [Local Setup](https://github.com/Relocate08/Relocate-Back-End-Rails/blob/main/README.md#local-setup)
* [Authors](https://github.com/Relocate08/Relocate-Back-End-Rails/blob/main/README.md#authors)

## Local Setup:

This project requires:
- Ruby 2.5.3.
- Rails 5.2.4.3

* Fork this repository
* Clone your fork
* Ensure the following gems are within the `:developement, :test do` block:
   * `gem 'rspec-rails'`
   * `gem 'capybara'`
   * `gem 'pry'`
   * `gem 'shoulda-matchers'`
   * `gem 'simplecov'`
   
* Example:
```ruby
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'capybara'
  gem 'pry'
  gem 'shoulda-matchers'
  gem 'simplecov'
end
```
* Ensure that the following gems exist outside of any blocks: (I like to put them just above the `group :developement, :test do` block:
 * `gem 'faraday'`
 * `gem 'figaro'`
 * `gem 'fast_jsonapi'`
 
* Example:
```ruby
...
gem 'figaro'
gem 'faraday'
gem 'fast_jsonapi'

group :development, :test do
...
```

From the command line, install the above gems and set up your DB by running:
    * `bundle install`
    * `rails db:create`
    * `rails db:migrate`    
* Install Figaro with `bundle exec figaro install` to create an application.yml file locally (this will need to be updated with any needed ENV variables!!!)(example: SOMETHING_API_KEY: 89798273429sadlfj332)

#### Sweater Weather utilizes the following gems and libraries in testing:

- [RSpec](https://github.com/rspec/rspec-rails)
- [ShouldaMatchers](https://github.com/thoughtbot/shoulda-matchers)
- [Capybara](https://github.com/teamcapybara/capybara)
- [SimpleCov](https://github.com/simplecov-ruby/simplecov)

* Example:

```ruby
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'capybara'
  gem 'pry'
  gem 'shoulda-matchers'
  gem 'simplecov'
end
```

## Authors
- **Dani Coleman** - *Turing Student* - [GitHub Profile](https://github.com/dcoleman21) - [Turing Alum Profile](https://alumni.turing.io/alumni/dani-coleman) - [LinkedIn](https://www.linkedin.com/in/dcoleman-21/)
