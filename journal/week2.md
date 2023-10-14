# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby

### Bundler

Bundler is a package manager for Ruby.
It's the primary way to install ruby packages (known as gems).

#### Install Gems

You need to create a Gemfile and define your gems in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command

This will install the gems on the system globally (unlike Node.js which installs packages in-place in a folder called node_modules)

A Gemfile.lock will be created to lock down the gem versions used in this project.

#### Executing ruby scripts in the context of bundler

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed. This is the way we set context.

### Sinatra

Sinatra is a micro web-framework for ruby to build web-apps.

Its great for mock or development servers and for very simple projects.

You can create a web-server in a single file.

Ref: [Sinatra for Ruby](https://sinatrarb.com/)

## Terratowns Mock Server

### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file.

## CRUD

Terraform Provider resources utilize CRUD.

CRUD stands for Create, Read Update, and Delete

Ref: https://en.wikipedia.org/wiki/Create,_read,_update_and_delete