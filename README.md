[![Build Status](https://travis-ci.org/jhsu802701/generic_app.svg?branch=master)](http://travis-ci.org/jhsu802701/generic_app)
[![Code Climate](https://codeclimate.com/github/jhsu802701/generic_app/badges/gpa.svg)](https://codeclimate.com/github/jhsu802701/generic_app)
<a href="https://codeclimate.com/github/jhsu802701/generic_app/coverage"><img src="https://codeclimate.com/github/jhsu802701/generic_app/badges/coverage.svg" /></a>
[![security](https://hakiri.io/github/jhsu802701/generic_app/master.svg)](https://hakiri.io/github/jhsu802701/generic_app/master)

# GenericApp

Welcome to GenericApp, the #1 Rails app generator!  No other method of starting a Rails app can save you so much time and effort.  Stop reinventing the wheel every time you start a new Rails project.  User authentication, comprehensive tests, Guard automation, Twitter bootstrap styling, and other features that are desirable in all or most Rails apps are implemented in advance.  You get post-installation scripts that consolidate routine multi-step tasks into one step, including the process of setting up your app for PostgreSQL.  Outlines of the initial MVC architecture of your new app are also provided.  Only GenericApp way gives you a comprehensive Rails app in just a few minutes.  If you're not exactly a GenericApp user, then you're not exactly viable at Startup Weekend or 24-hour web site challenges.
<br><br>
GenericApp also works for legacy Rails apps.  You can incorporate GenericApp's post-installation scripts into a legacy Rails app, including the PostgreSQL setup script and a script that prints out a list of all of the directories and files most relevant to the MVC architecture.

## Prerequisites

You must have not only Ruby on Rails installed but SQLite and PostgreSQL installed as well.  Everything you need to use the GenericApp gem is pre-installed in my Debian Stable Vagrant Box for Ruby On Rails ( https://github.com/jhsu802701/vagrant-debian-jessie-rvm ).

## Installation

Install the GenericApp gem with the command:

    $ gem install generic_app

## Usage

### Creating A Rails App

Go to the directory where you keep your Rails projects and enter the command "generic_app".  You will be asked to select the name of the directory you wish to use for your Rails project.
<br><br>
After you have provided all of the necessary parameters, your generic Rails project will not only be created for you but automatically tested as well.  This takes a few minutes instead of several long and grueling hours.

### Adding Generic App Features To An Existing Project

Go to the parent of the app's root directory.  Enter the command "generic_app_add".  You will be shown a list of all sub-directories within your present working directory.  Pick the sub-directory corresponding to your target app.  The Bash scripts and the list of directories and files within the project will be added.  Please note that you may need to revise some of the scripts provided by GenericApp, which is designed around the railstutorial.org Sample App.

## What's the point?

Welcome to Ruby On HIGH SPEED Rails!  The GenericApp gem saves you time by automatically providing the basic 
elements and features that nearly all Rails apps require.  Instead of spending hours reinventing the wheel, you 
can spend more of your time on the more advanced features and capabilities that are unique to your specific Rails 
app.  Modifying a generic app takes far less time than creating an app completely from scratch.
<br><br>
Creating a basic generic web site with user authentication and testing is a long and slow process that spans chapters 
3 through 10 in railstutorial.org.  The GenericApp Ruby gem allows you to create such a site in minutes instead of 
hours.  This is valuable for any project and essential for events like Startup Weekend and 24-hour website 
challenges.
<br><br>
The GenericApp gem copies the GenericApp Template (https://github.com/jhsu802701/generic_app_template) for use as a template for starting a new project.  Starting a Rails app completely from scratch (by using the "rails new" command) requires manually installing and configuring MiniTest, Guard, Twitter bootstrap, the user model, user sign-ups, user login/logout, user authorization, administrative users, account activations, and password resets.  People are often tempted to "save time" by omitting testing.  Using the GenericApp gem allows you to have all of the essential basic elements of a generic app as soon as you start it.  It's a shortcut that actually complies with best practices.

## Development

### Testing GenericApp
Download this GitHub repository, cd into the source code, and enter the command "sh gem_test.sh".  The screen output is saved to the log files in the log directory.  If all goes well, every test is completed with 0 or 31m0 failures and 0 errors.

## Contributing

1. Fork it ( https://github.com/jhsu802701/generic_app/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
