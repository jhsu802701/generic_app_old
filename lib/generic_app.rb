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
    self.add_to_file_if("#{subdir_name}/.gitignore", 'tmp*')
    self.add_to_file_if("#{subdir_name}/.gitignore", '.DS_Store')
    self.add_to_file_if("#{subdir_name}/.gitignore", 'notes/*.dot')
    self.add_to_file_if("#{subdir_name}/.gitignore", 'notes/*.svg')
    self.add_to_file_if("#{subdir_name}/.gitignore", 'gemsurance_report.html')
    path_gemfile = "#{subdir_name}/Gemfile"
    self.add_to_file_always(path_gemfile, '# Gems added by generic_app')
    self.add_to_file_always(path_gemfile, 'group :development, :test do')
    
    self.add_to_file_if(path_gemfile, "gem 'sandi_meter'")
    StringInFile.replace("gem 'sandi_meter'", "  gem 'sandi_meter'", path_gemfile)
    self.add_to_file_if(path_gemfile, "gem 'brakeman'")
    StringInFile.replace("gem 'brakeman'", "  gem 'brakeman'", path_gemfile)
    self.add_to_file_if(path_gemfile, "gem 'bundler-audit'")
    StringInFile.replace("gem 'bundler-audit'", "  gem 'bundler-audit'", path_gemfile)
    self.add_to_file_if(path_gemfile, "gem 'rails-erd'")
    StringInFile.replace("gem 'rails-erd'", "  gem 'rails-erd'", path_gemfile)
    self.add_to_file_if(path_gemfile, "gem 'railroady'")
    StringInFile.replace("gem 'railroady'", "  gem 'railroady'", path_gemfile)
    self.add_to_file_if(path_gemfile, "gem 'annotate'")
    StringInFile.replace("gem 'annotate'", "  gem 'annotate'", path_gemfile)
    self.add_to_file_if(path_gemfile, "gem 'gemsurance'")
    StringInFile.replace("gem 'gemsurance'", "  gem 'gemsurance'", path_gemfile)
    
    self.add_to_file_always(path_gemfile, 'end')
    
    self.copy_scripts (subdir_name)
    LineContaining.delete('***', "#{subdir_name}/test_code.sh")
    LineContaining.delete('rubocop', "#{subdir_name}/test_code.sh")
    LineContaining.delete('rails_best_practices', "#{subdir_name}/test_code.sh")
    LineContaining.delete('metric_fu', "#{subdir_name}/test_code.sh")
  end
  
  def self.add_to_file_always (filename, str)
    puts '------------------------------------'
    puts "Updating #{filename} (adding #{str})"
    text_from_file = File.read(filename)
    last_char = text_from_file[-1]
    open(filename, 'a') { |f|
      if last_char != "\n"
        f.puts "\n"
      end
      f.puts "\n#{str}"
    }
  end

  # Add to file if not already present
  def self.add_to_file_if (filename, str)
    if StringInFile.present(str, filename) == false
      self.add_to_file_always(filename, str)
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
