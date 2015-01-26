# GenericApp

## Installation

Install it yourself with the command:

    $ gem install generic_app

## Usage

Once you have installed this Ruby gem, just go to the directory where you 
keep your Rails projects and enter the command "generic_app".  You will be 
asked to provide a name for the subdirectory you wish to have created and 
used for your new Rails app.

## What's the point?

Welcome to Ruby On HIGH SPEED Rails!  The GenericApp gem saves you time by automatically providing the basic 
elements and features that nearly all Rails apps require.  Instead of spending hours reinventing the wheel, you 
can spend more of your time on the more advanced features and capabilities that are unique to your specific Rails 
app.  Modifying a generic app takes far less time than creating an app completely from scratch.
<br><br>
Creating a basic generic web site with user capability and testing is a long and slow process that spans chapters 
3 through 10 at railstutorial.org.  The GenericApp Ruby gem allows you to create such a site in seconds instead of 
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
7. User functionality: includes hashed passwords, administrative users, 
account activations, and password resets

This generic Rails app provides the above features PLUS these additional 
features:

1. Bash scripts in the root directory that allow you to perform routine 
tasks in only one step.  (These scripts are likely to be useful in Rails 
apps that were not created with this generic_app Ruby gem.)
2. Recommendations that the user make use of password management software 
to generate and store secure passwords
3. Outlines of the MVC, test suite, and database seeding process in the 
notes folder
4. Guard automatically runs tests upon startup.

## Contributing

1. Fork it ( https://github.com/jhsu802701/generic_app/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
