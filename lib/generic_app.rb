#!/usr/bin/ruby

require "generic_app/version"
require "string_in_file"
require "line_containing"

ENV['DIR_MAIN'] = File.expand_path("../../", __FILE__)
ENV['DIR_PARENT'] = File.expand_path("../../../", __FILE__)

module GenericApp
  # Create app, stick with SQLite database in development
  def self.create_new (subdir_name, email)
    self.git_clone (subdir_name)
    self.email_update(subdir_name, email)
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
  
  def self.email_update (subdir_name, email)
    email_orig = 'please-change-me-at-config-initializers-devise@example.com'
    path_of_email = "#{subdir_name}/config/initializers/devise.rb"
    StringInFile.replace(email_orig, email, path_of_email)
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

  def self.add (subdir_name)
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
    dir_template = "#{ENV['DIR_PARENT']}/high_speed_rails_clobbers_not_exactly"
    self.git_clone (dir_template)
    system("cp -r #{dir_template}/*.sh #{subdir_name}")
    system("cp -r #{dir_template}/*.rb #{subdir_name}")
    system("cp -r #{dir_template}/config/database-pg.yml #{subdir_name}/config")
    system("rm -rf #{dir_template}")
  end
end
