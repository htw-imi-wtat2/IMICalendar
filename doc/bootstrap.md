# Adding Bootstrap

## Installation
Starting with Bootstrap 4, Bootstrap can be directly installed as a gem using
the Gemfile/bundler:

    gem 'bootstrap', '~> 4.0.0.beta2'

### Steps from the [gem doc](https://github.com/twbs/bootstrap-rubygem/blob/master/README.md)
  import bootstrap into javascript and sass files. Ready to go!

* [Installation Documentation](https://getbootstrap.com/docs/4.0/getting-started/download/)
* [Bootstrap Gem Documentation](https://github.com/twbs/bootstrap-rubygem/blob/master/README.md)
* [Bootstrap Documentation](https://v4-alpha.getbootstrap.com/getting-started/introduction/)


[Follow the installation instructions there](https://github.com/twbs/bootstrap-rubygem/blob/master/README.md#a-ruby-on-rails):


Add `bootstrap` to your Gemfile:

```ruby
gem 'bootstrap', '~> 4.0.0.beta2.1'
```

Ensure that `sprockets-rails` is at least v2.3.2.

`bundle install` and restart your server to make the files available through the pipeline.

Import Bootstrap styles in `app/assets/stylesheets/application.scss`:

```scss
// Custom bootstrap variables must be set or imported *before* bootstrap.
@import "bootstrap";
```

The available variables can be found [here](assets/stylesheets/bootstrap/_variables.scss).

Make sure the file has `.scss` extension (or `.sass` for Sass syntax). If you have just generated a new Rails app,
it may come with a `.css` file instead. If this file exists, it will be served instead of Sass, so rename it:

```console
$ mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss
```

Then, remove all the `*= require` and `*= require_tree` statements from the Sass file. Instead, use `@import` to import Sass files.

Do not use `*= require` in Sass or your other stylesheets will not be able to access the Bootstrap mixins and variables.

Bootstrap JavaScript depends on jQuery.
If you're using Rails 5.1+, add the `jquery-rails` gem to your Gemfile:

```ruby
gem 'jquery-rails'
```

Bootstrap tooltips and popovers depend on [popper.js] for positioning.
The `bootstrap` gem already depends on the
[popper_js](https://github.com/glebm/popper_js-rubygem) gem.

Add Bootstrap dependencies and Bootstrap to your `application.js`:

```js
//= require jquery3
//= require popper
//= require bootstrap-sprockets
```

While `bootstrap-sprockets` provides individual Bootstrap components
for ease of debugging, you may alternatively require
the concatenated `bootstrap` for faster compilation:

```js
//= require jquery3
//= require popper
//= require bootstrap
```
