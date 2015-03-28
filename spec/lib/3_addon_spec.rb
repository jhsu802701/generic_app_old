require 'spec_helper'
require 'generic_app'
require 'string_in_file'

describe GenericApp do
  
  it "Adding scripts to an existing app should work" do
    puts "********************************************************"
    puts "Testing the addition of scripts to an existing Rails app"
    system("rm -rf tmp3")
    system("git clone https://github.com/mhartl/sample_app_3rd_edition.git tmp3")
    GenericApp.add_scripts ("tmp3")
  end
  
end

