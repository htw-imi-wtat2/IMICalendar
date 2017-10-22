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
