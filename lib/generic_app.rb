#!/usr/bin/ruby

require "generic_app/version"

class GenericApp

  def initialize
  end

  def create (subdir_name)
    subdir_name_final = subdir_name
    subdir_name_final = "sample_app_3rd_edition" if subdir_name == ""
    system("git clone https://github.com/mhartl/sample_app_3rd_edition.git #{subdir_name}")
    system("cd #{subdir_name} && git checkout remotes/origin/account-activation-password-reset")
    
    dir_main = File.expand_path("../../", __FILE__)
    system("cp -r #{dir_main}/to_add/* #{subdir_name}")
    
    system("cd #{subdir_name} && rm -rf .git")
    system("cd #{subdir_name} && git init")
  end
end
