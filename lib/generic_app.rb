#!/usr/bin/ruby

require "generic_app/version"
require "string_in_file"

class GenericApp

  def initialize
  end

  def create (subdir_name)
    dir_main = File.expand_path("../../", __FILE__)
    subdir_name_final = subdir_name
    subdir_name_final = "sample_app_3rd_edition" if subdir_name == ""
    t1 = Thread.new { 
      puts "*************************************************"
      puts "Downloading the Sample App from railstutorial.org"
      system("git clone https://github.com/mhartl/sample_app_3rd_edition.git #{subdir_name}")
      system("cd #{subdir_name} && git checkout remotes/origin/account-activation-password-reset")
      }
    t1.join
    t1 = Thread.new { 
      puts "*******************************"
      puts "Modifying the Rails source code"
      str_guard_orig = "all_on_start: false"
      str_guard_new = "all_on_start: true"
      StringInFile.replace(str_guard_orig, str_guard_new, "#{subdir_name}/Guardfile")
      system("cp -r #{dir_main}/to_add/* #{subdir_name}")
      system("cd #{subdir_name} && sh list_files.sh >> notes/list_files.txt")
      
      system("cd #{subdir_name} && rm -rf .git")
      system("cd #{subdir_name} && git init")
      }
    t1.join
    puts "*************************************************************"
    puts "Enter the following commands to set up and test your new app:"
    puts "cd #{subdir_name}"
    puts "sh setup.sh"
    puts "***********"
    puts
  end
end
