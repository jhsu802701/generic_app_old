#!/usr/bin/ruby

require 'generic_app/version'
require 'string_in_file'
require 'line_containing'

ENV['DIR_MAIN'] = File.expand_path('../../', __FILE__)
ENV['DIR_PARENT'] = File.expand_path('../../../', __FILE__)

#
module GenericApp
  # Create app, stick with SQLite database in development
  def self.create_new(subdir_name, email)
    t1 = Thread.new { self.git_clone(subdir_name) }
    t1.join
    self.email_update(subdir_name, email)
    self.git_init(subdir_name)
  end

  def self.git_clone(subdir_name)
    puts '------------------------------------'
    puts 'Downloading the Generic App Template'
    system("git clone https://github.com/jhsu802701/generic_app_template.git #{subdir_name}")
  end

  def self.email_update(subdir_name, email)
    email_orig = 'please-change-me-at-config-initializers-devise@example.com'
    path_of_email = "#{subdir_name}/config/initializers/devise.rb"
    StringInFile.replace(email_orig, email, path_of_email)
  end

  def self.git_init(subdir_name)
    puts '----------------'
    puts 'Initializing Git'
    system("cd #{subdir_name} && rm -rf .git")
    system("cd #{subdir_name} && git init")
    system("cd #{subdir_name} && git add .")
    system("cd #{subdir_name} && git commit -m 'Initial commit' >/dev/null")
  end
end
