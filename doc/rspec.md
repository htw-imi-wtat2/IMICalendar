# RSpec

RSpec is a ruby testing framework. We use it because

* it has support for testing JavaScript
* it is popular among ruby developers
* before rails 5.1 the included rails testing framework didn't offer end-to-end tests
* it's syntax is similar to the Jasmine JS Testing framework

## Installation

There is a gem [rspec-rails](https://github.com/rspec/rspec-rails) that makes
using rspec within rails easy:

Add the gem in the gemfile for the test and development environments:

    gem 'rspec-rails', '~> 3.6'

and run

    bundle install

and

    rails generate rspec:install

## End to End Tests with Capybara (without JavaScript)

Rails 5.1 has capybara already installed, if not (e.g. because you skipped the
  tests with rails new) add it to the gemfile:

    gem "capybara"

And then follow the documentation under
 "[Using Capybara with RSpec](https://github.com/teamcapybara/capybara#using-capybara-with-rspec)":

* add `require 'capybara/rspec'` to spec_helper.rb
* create feature test under spec/features (see committed file)
* note that the specs need to import rails_helper.rb which imports spec_helper.rb

Further documentation (especially read through the DSL doc!)

* [Capybara](https://github.com/teamcapybara/capybara)
* [Using Capybara with RSpec](https://github.com/teamcapybara/capybara#using-capybara-with-rspec)
* [Capybara - The DSL](https://github.com/teamcapybara/capybara#the-dsl)
