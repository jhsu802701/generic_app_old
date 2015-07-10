#!/usr/bin/ruby

require "generic_app/version"
require "string_in_file"
require "line_containing"

ENV['DIR_MAIN'] = File.expand_path("../../", __FILE__)
ENV['DIR_PARENT'] = File.expand_path("../../../", __FILE__)

module GenericApp
  # Create app, stick with SQLite database in development
  def self.sq (subdir_name)
    self.git_clone (subdir_name)
    self.git_init (subdir_name)
  end

  def self.git_clone (subdir_name)
    puts "------------------------------------"
    puts "Downloading the Generic App Template"
    t1 = Thread.new {
      system("git clone https://github.com/jhsu802701/generic_app_template.git #{subdir_name}")
    }
    t1.join
  end

  def self.git_init (subdir_name)
    puts "----------------"
    puts "Initializing Git"
    t1 = Thread.new {
      $stdout = File.new( '/dev/null', 'w' )
      system("cd #{subdir_name} && rm -rf .git")
      system("cd #{subdir_name} && git init")
      system("cd #{subdir_name} && git add .")
      system("cd #{subdir_name} && git commit -m 'Initial commit' >/dev/null")
      $stdout = STDOUT
    }
    t1.join
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
    self.git_clone (subdir_name)
    system("rm #{subdir_name}/db/*.sqlite")
    t1 = Thread.new {
      self.set_pg_params(subdir_name, db_rootname_x, var_store_username, var_store_password, username_x, password_x)
    }
    t1.join
    self.git_init (subdir_name)
  end

  def self.set_pg_params (subdir_name, db_rootname_x, var_store_username, var_store_password, username_x, password_x)
    d_d = "#{db_rootname_x}_dev"
    d_t = "#{db_rootname_x}_test"
    d_p = "#{db_rootname_x}_pro"
    v_u = var_store_username
    v_p = var_store_password
    u = username_x
    p = password_x
    system("cd #{subdir_name} && ruby setup-pg.rb #{d_d} #{d_t} #{d_p} #{v_u} #{v_p} #{u} #{p}")
  end

  def self.add_sq (subdir_name)
    self.update_gitignore (subdir_name)
    self.copy_scripts (subdir_name)
  end

  def self.update_gitignore (subdir_name)
    puts "-------------------"
    puts "Updating .gitignore"
    if StringInFile.present("tmp*","#{subdir_name}/.gitignore") == false
      command = 'echo "\ntmp*" >> '
      command += "#{subdir_name}/.gitignore"
      system(command)
    end
    if StringInFile.present(".DS_Store","#{subdir_name}/.gitignore") == false
      command = 'echo "\n.DS_Store" >> '
      command += "#{subdir_name}/.gitignore"
      system(command)
    end
  end

  def self.copy_scripts (subdir_name)
    puts "----------------------------------------------"
    puts "Adding scripts and config/database-pg.yml file"
    dir_template = "#{ENV['DIR_PARENT']}/template"
    self.git_clone (dir_template)
    system("cp -r #{dir_template}/*.sh #{subdir_name}")
    system("cp -r #{dir_template}/*.rb #{subdir_name}")
    system("cp -r #{dir_template}/config/database-pg.yml #{subdir_name}/config")
    system("rm -rf #{dir_template}")
  end

  def self.add_pg (subdir_name, db_rootname_x, var_store_username, var_store_password, username_x, password_x)
    self.update_gitignore (subdir_name)
    self.copy_scripts (subdir_name)
    t1 = Thread.new {
      self.set_pg_params(subdir_name, db_rootname_x, var_store_username, var_store_password, username_x, password_x)
    }
    t1.join
  end
end
