# Devise

The IMI-Calendar app will have two roles: admins and users.
Admins can create and edit events, users can see and search them.
Users don't need to log in. To aquire the admin role, admins need to log in.

Later on this will be supplemented with an ldap-Connection enabling users and
admins to use logins of FB4. This introduces the possibility to show special
events only to members of the FB4.

## Installation

Add gem and run bundler:

    gem 'devise'

run generator:

    rails generate devise:install

This yields the following output (see result in commit):
<pre>
    Running via Spring preloader in process 38365
          create  config/initializers/devise.rb
          create  config/locales/devise.en.yml
    ===============================================================================

    Some setup you must do manually if you haven't yet:

      1. Ensure you have defined default url options in your environments files. Here
         is an example of default_url_options appropriate for a development environment
         in config/environments/development.rb:

           config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

         In production, :host should be set to the actual host of your application.

      2. Ensure you have defined root_url to *something* in your config/routes.rb.
         For example:

           root to: "home#index"

      3. Ensure you have flash messages in app/views/layouts/application.html.erb.
         For example:

           <p class="notice"><%= notice %></p>
           <p class="alert"><%= alert %></p>

      4. You can copy Devise views (for customization) to your app by running:

           rails g devise:views
</pre>

## Devise Modules

As the login will be managed via ldap later on, I will not need features like
password recovery via email or email validation. If you consider using them,
consider postponing them to a second step as you will need to set up connection
to an email provider which tends to be a hassle.

## Chapter 2 Copeland

I've followed Chapter 2 of Copeland, see commits:

A2-Devise: Styling the Login and Registration Forms (Copeland P. 20 ff)
A2-Devise: Validating Registration (Copeland P. 26 ff)

## Finetuning Access - Whitelisting

With the `before_action :authenticate_user!` in the applicaton_controller.rb
all pages require a login. For the
IMI-Calendar Page this is not the case, as some pages should be accessible
without login. In fact, most apps will want a friendly welcome page rather than
a harsh "login first!" page welcoming their users.

    skip_before_action :authenticate_user!, only: [:index]

in EventsController does that. Even if you have many pages not requiring login
use the whitelist method rather than blacklisting:
If you close everything and open specific pages, the chances that you have a
page open to the public that shouldn't be open are less.

## Resources
* [Devise](https://github.com/plataformatec/devise)
