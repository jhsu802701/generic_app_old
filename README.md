# GenericApp

## Prerequisites

You must have not only Ruby on Rails installed but PostgreSQL installed as well.  Everything you need to use GenericApp is pre-installed in my Debian Stable Vagrant Box for Ruby On Rails ( https://github.com/jhsu802701/vagrant_debian_wheezy_rvm ).

## Installation

Install it yourself with the command:

    $ gem install generic_app

## Usage

### Creating A Rails App

Go to the directory where you keep your Rails projects and enter the command "generic_app".  You will be asked to select the name of the directory you wish to use for your Rails project, and you will be asked whether you wish to use the SQLite or PostgreSQL database in your development environment.  If you choose PostgreSQL, you will be asked for database parameters.
<br><br>
After you have provided all of the necessary parameters, your generic Rails project will not only be created for you but automatically tested as well.  All this takes a few minutes instead of several long and grueling hours.

### Adding Generic App Features To An Existing Project

Go to the parent of the app's root directory.  Enter the command "generic_app_add".  You will be shown a list of all sub-directories within your present working directory.  Pick the sub-directory corresponding to your target app.  The Bash scripts and the list of directories and files within the project will be added.  Please note that you may need to revise the test.sh script created in the project, which is designed around the railstutorial.org Sample App.

## What's the point?

Welcome to Ruby On HIGH SPEED Rails!  The GenericApp gem saves you time by automatically providing the basic 
elements and features that nearly all Rails apps require.  Instead of spending hours reinventing the wheel, you 
can spend more of your time on the more advanced features and capabilities that are unique to your specific Rails 
app.  Modifying a generic app takes far less time than creating an app completely from scratch.
<br><br>
Creating a basic generic web site with user capability and testing is a long and slow process that spans chapters 
3 through 10 in railstutorial.org.  The GenericApp Ruby gem allows you to create such a site in seconds instead of 
hours.  This is valuable for any project and essential for events like Startup Weekend and 24-hour website 
challenges.
<br><br>
The GenericApp gem copies the railstutorial.org Sample App for use as a template for starting a new project.  
(Note that the microposts and followers features are not included, because they are specific to the Sample App.)  
Starting a Rails app completely from scratch (by using the "rails new" command) requires manually installing and 
configuring MiniTest, Guard, Twitter bootstrap, the user model, user sign-ups, user login/logout, user 
authorization, administrative users, account activations, and password resets.  People are often tempted to "save 
time" by omitting testing.  Using the GenericApp gem allows you to have all of the essential basic elements of a 
generic app as soon as you start it.  It's a shortcut that actually complies with best practices.
<br><br>
The original Rails Tutorial Sample App provides the following features:

1. Static pages
2. Tests
3. Automated tests through Guard
4. Twitter bootstrap
5. Databases: SQLite3 for development and PostgreSQL for production
6. Ready for Heroku deployment
7. User functionality: includes hashed passwords, administrative users, account activations, and password resets

This generic Rails app provides the above features PLUS these additional 
features:

1. Bash scripts in the root directory that allow you to perform routine tasks in only one step.  (These scripts are likely to be useful in Rails apps that were not created with this generic_app Ruby gem.)
2. Recommendations that the user make use of password management software to generate and store secure passwords
3. Outlines of the MVC, test suite, and database seeding process in the notes folder
4. Guard automatically runs tests upon startup.
5. If you choose PostgreSQL (instead of SQLite) as your development environment database, the parameters are automatically set on your machine AND in the app for you, and the username and password are EXCLUDED from the source code saved with Git.

## Development

### Testing GenericApp
Download this GitHub repository, cd into the source code, and enter the command "sh gem_test.sh".  The screen output is saved to the log files in the log directory.  If all goes well, every test is completed with 0 or 31m0 failures and 0 errors.

### Special Note on Figaro
The Figaro gem is used for this gem AND any PostgreSQL projects created.  In the interest of avoiding confusion, the same versions of Figaro are specified in the GenericApp gemspec AND in the Gemfile of PostgreSQL-based projects created with this gem.

## Contributing

1. Fork it ( https://github.com/jhsu802701/generic_app/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
