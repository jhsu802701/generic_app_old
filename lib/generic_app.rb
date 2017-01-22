#!/usr/bin/ruby

require 'generic_app/version'
require 'string_in_file'
require 'line_containing'

DIR_MAIN = File.expand_path('../../', __FILE__)
DIR_PARENT = File.expand_path('../../../', __FILE__)

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
    url_template = StringInFile.read("#{DIR_MAIN}/lib/generic_app/git_clone_url.txt")
    system("git clone #{url_template} #{subdir_name}")
  end

  def self.email_update(subdir_name, email)
    email_orig = 'somebody@rubyonracetracks.com'
    path_of_email_1 = "#{subdir_name}/config/initializers/devise.rb"
    path_of_email_2 = "#{subdir_name}/app/views/static_pages/contact.html.erb"
    StringInFile.replace(email_orig, email, path_of_email_1)
    StringInFile.replace(email_orig, email, path_of_email_2)
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
