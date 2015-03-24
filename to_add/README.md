# Generic App

This is the generic Rails app created with the use of the generic_app Ruby gem.  More details on the generic_app Ruby gem are available at https://github.com/jhsu802701/generic_app .

This app consists of all of the features of the Rails Tutorial Sample App except for microposts and relationships.  The basic elements essential to most Rails apps are included.  It is up to you to customize this app and add the features and capabilities specific to your endeavor.

The original Rails Tutorial Sample App provides the following features:

1. Static pages
2. Tests
3. Automated tests through Guard
4. Twitter bootstrap
5. Databases: SQLite3 for development and PostgreSQL for production
6. Ready for Heroku deployment
7. User functionality: includes hashed passwords, administrative users, account activations, and password resets

This generic Rails app provides the above features PLUS these additional features:

1. Bash scripts in the root directory that allow you to perform routine tasks in only one step.  (These scripts are likely to be useful in Rails apps that were not created with this generic_app Ruby gem.)
2. Recommendations that the user make use of password management software to generate and store secure passwords
3. Outlines of the MVC, test suite, and database seeding process in the notes folder
4. Guard automatically runs tests upon startup.

To execute the Bash (*.sh) scripts, enter the command "sh (name of script)".  The Bash scripts provided are:

1. test.sh: When you first create the app, or anytime that you clone this app, you must run the setup.sh script to set up the app.  This is a prerequisite for running Guard, running the local server, and many other basic tasks.
2. server.sh: This script runs your local Rails server.  Note that it specifies port 0.0.0.0 so that you can view your Rails app in your web browser when you do your Rails development in Vagrant.
3. seed.sh: This script populates the database in the development environment with simulated data.
4. sandbox.sh: This script gives you the Rails console sandbox environment.
5. heroku_upload.sh: This script uploads your Rails source code to Heroku AND runs the "rake db:migrate" command in the Heroku environment.
6. kill_spring.sh: The Spring tool is useful but may occasionally slow down your Rails app.  If you believe that this is happening, run this script to kill the Spring tool.
7. list_files.sh: This script prints outlines of the path structure of the MVC and testing architectures in your Rails app into the file notes/1-list_files.txt.  While this script has no impact on how your Rails app runs, it aids the process of outlining the MVC structure and the testing procedure in your app.
