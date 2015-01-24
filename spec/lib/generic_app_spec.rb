require 'spec_helper'
require 'generic_app'
require 'string_in_file'
require 'string_in_path'

describe GenericApp do
  it "should copy the Rails tutorial" do
    puts "*********************************"
    puts "Clearing space for Rails tutorial"
    system("rm -rf tmp")
    
    t1 = Thread.new { 
      generic_app = GenericApp.new
      generic_app.create("tmp")
     }
    t1.join

    t1 = Thread.new { 
      puts "\nChecking files in app"
      #expect(StringInPath.present("micropost", "tmp")).to eq(false)
      expect(StringInPath.present("Micropost", "tmp")).to eq(false)
      expect(StringInPath.present("follower", "tmp")).to eq(false)
      expect(StringInPath.present("Follower", "tmp")).to eq(false)
      expect(StringInPath.present("relationship", "tmp")).to eq(false)
      expect(StringInPath.present("Relationship", "tmp")).to eq(false)
      expect(StringInFile.present("rake", "tmp/setup.sh")).to eq(true)
      expect(StringInFile.present("all_on_start: true", "tmp/Guardfile")).to eq(true)
     }
    t1.join
    
  end
end

def cd_dir_execute (dir_cd, command)
  system ("cd #{dir_cd} && #{command}")
end

def check
  puts "\nChecking files in app"
  system("cat /home/vagrant/shared/generic_app/tmp/setup.sh")
  system("pwd")
  puts StringInFile.present("rake", "/home/vagrant/shared/generic_app/tmp/setup.sh")
  expect(StringInFile.present("rake", "/home/vagrant/shared/generic_app/tmp/setup.sh")).to eq(true)
end
