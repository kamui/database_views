DatabaseViews
=============

[![Build Status](https://secure.travis-ci.org/kamui/database_views.png)](http://travis-ci.org/kamui/database_views)

DatabaseViews is Rails 3.x plugin that allows you to store and load views from the database. It currently supports Monoid, but is extensible enough to support other ORMs.

Installation
------------

Add in your Gemfile:

```ruby
gem 'database_views'
```

Usage
-----

Create a view template model that includes `DatabaseViews::Orm::Mongoid`. You can name this model whatever you like, I'll use `ViewTemplate` in this example.

```bash
rails g model ViewTemplate
````

In the `model`:

```ruby
class ViewTemplate
  include Mongoid::Document
  include Mongoid::Timestamps
  include DatabaseViews::Orm::Mongoid
end
```

Here are the fields `DatabaseViews::Orm::Mongoid` adds:

`path` - The path to the view template. Excludes any file extensions (ie. "posts/index").

`contents` - The body of the view template.

`formats` (default: :html) - Format the handler renders to.

`locale` (default: :en) - Locale of the template.

`handlers` (default: :erb) - The template handler for this extension (ie. :erb, :haml).

In the your controller, you can `prepend_view_path` if you want your Rails to check your resolver first for the view template, or you can `append_view_path`, if you want it check your resolver at the end of the lookup stac.k

```ruby
class ApplicationController < ActionController::Base
  append_view_path ViewTemplate.resolver
  # prepend_view_path ViewTemplate.resolver
end
```

How does it work?
-----------------

DatabaseViews defines a `DatabaseResolver` that extends `ActionView::PathResolver`. A `#query` method is defined on this class that tells the resolver how to look up a template in the database. In the controller, prepending or appending your resolver to the view path will include it in the lookup stack when Rails looks for a view template to render.

Credits
-------

This [blog post](http://www.arailsdemo.com/posts/50) by arailsdemo, was very helpful in understanding how view templates and resolvers worked in Rails 3. I'd also recommend [Crafting Rails Applications](http://pragprog.com/book/jvrails/crafting-rails-applications) by José Valim.