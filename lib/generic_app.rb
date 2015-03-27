#!/usr/bin/ruby

require "generic_app/version"
require "string_in_file"
require "line_containing"

ENV['DIR_MAIN'] = File.expand_path("../../", __FILE__)

module GenericApp
  
  # Create app, stick with SQLite database in development
  def self.sq (subdir_name)
    t1 = Thread.new { 
      self.git_clone (subdir_name)
    }
    t1.join
    self.guard_file (subdir_name)
    self.app_views_password (subdir_name)
    self.guard_file (subdir_name)
    self.app_views_password (subdir_name)
    self.git_init (subdir_name)
    self.add_scripts (subdir_name)
    self.add_notes (subdir_name)
    self.add_readme (subdir_name)
    t1 = Thread.new { 
      self.update_gitignore (subdir_name)
    }
    t1.join
  end
  
  def self.git_clone (subdir_name)
    puts "*************************************************"
    puts "Downloading the Sample App from railstutorial.org"
    system("git clone https://github.com/mhartl/sample_app_3rd_edition.git #{subdir_name}")
    system("cd #{subdir_name} && git checkout remotes/origin/account-activation-password-reset")

  end
  
  def self.guard_file (subdir_name)
    puts "*************************************************************"
    puts "Setting the Guardfile to automatically run tests upon startup"
    str_guard_orig = "all_on_start: false"
    str_guard_new = "all_on_start: true"
    StringInFile.replace(str_guard_orig, str_guard_new, "#{subdir_name}/Guardfile")
  end
  
  def self.app_views_password (subdir_name)
    puts "*********************************************************************************"
    puts "Advising users to use a password management program to create and store passwords"
    str1 = "</h1>"
    str2a = "</h1>"
    str2b = "\nUsing the same password for all of your accounts is risky."
    str2b += "\nLimiting yourself to passwords that you can easily remember is risky."
    str2b += "\nYou should use a password management program like <a href='http://www.keepassx.org/'>KeePassX</a>"
    str2b += "\nto create much better passwords AND store them in encrypted form.<br>"
    str2 = str2a + str2b
    StringInFile.replace(str1, str2, "#{subdir_name}/app/views/users/new.html.erb")
    StringInFile.replace(str1, str2, "#{subdir_name}/app/views/users/edit.html.erb")
    StringInFile.replace(str1, str2, "#{subdir_name}/app/views/password_resets/new.html.erb")
    StringInFile.replace(str1, str2, "#{subdir_name}/app/views/password_resets/edit.html.erb")
  end
  
  def self.git_init (subdir_name)
    puts "****************"
    puts "Initializing Git"
    $stdout = File.new( '/dev/null', 'w' )
    system("cd #{subdir_name} && rm -rf .git")
    system("cd #{subdir_name} && git init")
    system("cd #{subdir_name} && git add .")
    system("cd #{subdir_name} && git commit -m 'Initial commit' >/dev/null")
    $stdout = STDOUT
  end
  
  def self.add_scripts (subdir_name)
    puts "*******************"
    puts "Adding Bash scripts"
    system("cp -r #{ENV['DIR_MAIN']}/to_add/*.sh #{subdir_name}")
    system("cd #{subdir_name} && sh list_files.sh")
  end
  
  def self.add_notes (subdir_name)
    puts "*****************************"
    puts "Adding notes on MVC structure"
    system("mkdir -p #{subdir_name}/notes")
    system("cp -r #{ENV['DIR_MAIN']}/to_add/notes/* #{subdir_name}/notes")
  end
  
  def self.add_readme (subdir_name)
    puts "*****************************"
    puts "Adding README"
    system("cp -r #{ENV['DIR_MAIN']}/to_add/README.md #{subdir_name}")
  end
  
  def self.update_gitignore (subdir_name)
    puts "*******************"
    puts "Updating .gitignore"
    if StringInFile.present("tmp*","#{subdir_name}/.gitignore") == false
      command = 'echo "tmp*" >> '
      command += "#{subdir_name}/.gitignore"
      system(command)
    end
    if StringInFile.present(".DS_Store","#{subdir_name}/.gitignore") == false
      command = 'echo ".DS_Store" >> '
      command += "#{subdir_name}/.gitignore"
      system(command)
    end
  end
  
  # Create app, use PostgreSQL instead of SQLite
  # NOTE: Three databases are used: development, testing, and production.
  # NOTE: Each database has the same username and password.

  # INPUT PARAMETERS:
  # Name of directory containing the app
  # Database root name
  # Name of environmental variable used to store the username
  # Name of environmental variable used to store the password
  # Username
  # Password

  def self.pg (subdir_name, db_rootname_x, var_store_username, var_store_password, username_x, password_x)
    self.sq (subdir_name)
    self.pg_gemfile (subdir_name)
    t1 = Thread.new { 
      self.set_pg_params(subdir_name, db_rootname_x, var_store_username, var_store_password, username_x, password_x)
    }
    t1.join
  end
  
  def self.pg_gemfile (subdir_name)
    puts "**************************************************************************"
    puts "Updating the Gemfile (PostgreSQL for development, testing, and production)"
    LineContaining.delete("sqlite", "#{subdir_name}/Gemfile")
    LineContaining.delete("gem 'pg'", "#{subdir_name}/Gemfile")
    open("#{subdir_name}/Gemfile", 'a') {|f|
      f << "\n\ngem 'pg'\n"
      f << "gem 'figaro'\n"
    }
  end
  
  def self.set_pg_params (subdir_name, db_rootname_x, var_store_username, var_store_password, username_x, password_x)
    system("cp -r #{ENV['DIR_MAIN']}/to_add_pg/* #{subdir_name}")
    puts "*********************************************"
    puts "Setting up the PostgreSQL database parameters"
    # NOTE: These environmental variables are temporary and only used here.
    ENV['APP_DB_NAME_DEV'] = "#{db_rootname_x}_dev"
    ENV['APP_DB_NAME_TEST'] = "#{db_rootname_x}_test"
    ENV['APP_DB_NAME_PRO'] = "#{db_rootname_x}_pro"
    ENV['APP_DB_USER'] = username_x
    ENV['APP_DB_PASS'] = password_x
    system(%q{sudo -u postgres psql -c"CREATE ROLE $APP_DB_USER WITH CREATEDB LOGIN PASSWORD '$APP_DB_PASS';"})
    
    # Development database
    system(%q{sudo -u postgres psql -c"CREATE DATABASE $APP_DB_NAME_DEV WITH OWNER=$APP_DB_USER;"})
    system("wait")
    
    # Testing database
    system(%q{sudo -u postgres psql -c"CREATE DATABASE $APP_DB_NAME_TEST WITH OWNER=$APP_DB_USER;"})
    system("wait")
    
    # Production database
    system(%q{sudo -u postgres psql -c"CREATE DATABASE $APP_DB_NAME_PRO WITH OWNER=$APP_DB_USER;"})
    system("wait")
    
    puts "**************************************************"
    puts "Using Figaro to create initial configuration files"
    system("cd #{subdir_name} && figaro install")
    
    puts
    puts "*********************************"
    puts "Setting up config/application.yml"
    open("#{subdir_name}/config/application.yml", 'a') { |f|
      f << "\n\n"
      f << 'VAR_STORE_USERNAME: "USERNAME123"'
      f << "\n"
      f << 'VAR_STORE_PASSWORD: "PASSWORD123"'
    }
    StringInFile.replace("VAR_STORE_USERNAME", var_store_username, "#{subdir_name}/config/application.yml")
    StringInFile.replace("USERNAME123", username_x, "#{subdir_name}/config/application.yml")
    StringInFile.replace("VAR_STORE_PASSWORD", var_store_password, "#{subdir_name}/config/application.yml")
    StringInFile.replace("PASSWORD123", password_x, "#{subdir_name}/config/application.yml")
    
    puts
    puts "******************************"
    puts "Setting up config/database.yml"
    system("cp -r #{ENV['DIR_MAIN']}/to_add_pg/* #{subdir_name}")
    StringInFile.replace("VAR_STORE_USERNAME", var_store_username, "#{subdir_name}/config/database.yml")
    StringInFile.replace("VAR_STORE_PASSWORD", var_store_password, "#{subdir_name}/config/database.yml")
    StringInFile.replace("DB_NAME_DEV", ENV['APP_DB_NAME_DEV'], "#{subdir_name}/config/database.yml")
    StringInFile.replace("DB_NAME_TEST", ENV['APP_DB_NAME_TEST'], "#{subdir_name}/config/database.yml")
    StringInFile.replace("DB_NAME_PRO", ENV['APP_DB_NAME_PRO'], "#{subdir_name}/config/database.yml")
  end
  
end
