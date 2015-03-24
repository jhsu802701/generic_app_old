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
      puts "*************************************************************"
      puts "Setting the Guardfile to automatically run tests upon startup"
      str_guard_orig = "all_on_start: false"
      str_guard_new = "all_on_start: true"
      StringInFile.replace(str_guard_orig, str_guard_new, "#{subdir_name}/Guardfile")
      
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

      puts "*************************************"
      puts "Adding notes and routine task scripts"
      system("cp -r #{dir_main}/to_add/* #{subdir_name}")
      system("cd #{subdir_name} && sh list_files.sh")
      
      puts "********************************************"
      puts "Adding tmp* and .DS_Store to .gitignore file"
      open("#{subdir_name}/.gitignore", 'a') { |f|
        f << "\n\n"
        f << "\ntmp*"
        f << "\n.DS_Store"
      }
      
      # Initializing Git
      system("cd #{subdir_name} && rm -rf .git")
      system("cd #{subdir_name} && git init")
      system("cd #{subdir_name} && git add .")
      system("cd #{subdir_name} && git commit -m 'Initial commit'")
      }
    t1.join
  end
end
