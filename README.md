[![Gem Version](https://badge.fury.io/rb/generic_app.svg)](http://badge.fury.io/rb/generic_app)
[![Dependency Status](https://gemnasium.com/jhsu802701/generic_app.svg)](https://gemnasium.com/jhsu802701/generic_app)
[![Build Status](https://travis-ci.org/jhsu802701/generic_app.svg?branch=master)](http://travis-ci.org/jhsu802701/generic_app)
[![Code Climate](https://codeclimate.com/github/jhsu802701/generic_app/badges/gpa.svg)](https://codeclimate.com/github/jhsu802701/generic_app)
<a href="https://codeclimate.com/github/jhsu802701/generic_app/coverage"><img src="https://codeclimate.com/github/jhsu802701/generic_app/badges/coverage.svg" /></a>
[![security](https://hakiri.io/github/jhsu802701/generic_app/master.svg)](https://hakiri.io/github/jhsu802701/generic_app/master)

# GenericApp

Welcome to GenericApp, the #1 most comprehensive Rails app generator!  No other method of starting a Rails app can save you so much time and effort.  Stop reinventing the wheel every time you start a new Rails project.  User authentication, comprehensive tests, Twitter bootstrap styling, and other features that are desirable in all or most Rails apps are implemented in advance.  You get post-installation scripts that consolidate routine multi-step tasks into one step, including the process of setting up your app for PostgreSQL.  Outlines of the initial MVC architecture of your new app are also provided.  Only GenericApp way gives you a comprehensive Rails app in just a few minutes.  If you're not exactly a GenericApp user, then you're not exactly viable at Startup Weekend or 24-hour web site challenges.

## Prerequisites

You must have not only Ruby on Rails installed but SQLite and PostgreSQL installed as well.  Everything you need to use the GenericApp gem is pre-installed in my general purpose Debian Stable Docker image (rbenv-general) for Ruby On Rails.  To get started, go to the [Ruby on Racetracks web site] (http://www.rubyonracetracks.com/install).

## Installation

Install the GenericApp gem with the command:

    $ gem install generic_app

## Usage

Go to the directory where you keep your Rails projects and enter the command "generic_app".
<br><br>
After you have provided all of the necessary parameters, your generic Rails project will not only be created for you but automatically tested, outlined, and seeded as well.  This takes a few minutes instead of many long and grueling hours.

## How Does This Work?

This gem downloads and modifies the source code from the URL listed in the lib/generic_app/git_clone_url.txt file.  In other words, this gem uses a pre-existing Rails template app as the basis for your new app.

## How Is That Rails Template App Created?

I created this Rails Template App by following my [Rails From Scratch](http://www.rubyonracetracks.com/rails_from_scratch.html) protocol.

## What's the point?
* Creating a basic generic web site with user authentication and testing is a long and slow process that spans multiple long chapters in Rails Tutorial. The GenericApp Ruby gem allows you to create such a site in minutes instead of hours or days. This is valuable for any project and essential for events like Startup Weekend and 24-hour website challenges.
* GenericApp saves you time by automatically providing the basic elements and features that nearly all Rails apps require. Instead of spending hours reinventing the wheel, you can spend more of your time on the more advanced features and capabilities that are unique to your specific Rails app. Modifying a generic app takes far less time than creating an app completely from scratch.
* At the same time GenericApp provides superior quality. Unlike other Rails app generating systems, GenericApp INCLUDES comprehensive model, controller, and integration tests. The time you save allows you to get work done faster AND double down on quality control.
* By default, GenericApp respects the privacy of the users of your app.  The only people who can view information on a given user are that given user and your app's admins.  Other users and the general public are not allowed to view information on that user.  While the assumption that user information should be private won't be true for all apps, it's better to err on the side of too much privacy rather than too little, and it's still much easier to modify the app than to create a new one completely from scratch.

## Development

### Testing GenericApp
Download this GitHub repository, cd into the source code, and enter the command "sh gem_test.sh".  The screen output is saved to the log files in the log directory.  If all goes well, every test is completed with 0 failures and 0 errors.  Please note that bundle-audit will flag the outdated gems that result from using the old versions of the rails, pg, and nokogiri gems from the Rails Tutorial Sample App.  You should update the Gemfile to the newer versions of these gems available in the rbenv-general version of the Docker image.

### Contributing

1. Fork it ( https://github.com/jhsu802701/generic_app/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
