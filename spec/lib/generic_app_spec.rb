require 'spec_helper'
require 'generic_app'
require 'string_in_file'

describe GenericApp do
  it "should copy the Rails tutorial" do
    t1 = Thread.new { clear_space }
    t1.join
    t1 = Thread.new { clone }
    t1.join
    t1 = Thread.new { check }
    t1.join
    t1 = Thread.new { setup }
    t1.join
  end
end

def cd_dir_execute (dir_cd, command)
  system ("cd #{dir_cd} && #{command}")
end

def clear_space
  puts "\nClearing space for Rails tutorial"
  system("rm -rf tmp")
end

def clone
  puts "\nBegin cloning Rails tutorial"
  generic_app = GenericApp.new
  generic_app.create("tmp")
end

def check
  puts "\nChecking files in app"
  system("cat /home/vagrant/shared/generic_app/tmp/setup.sh")
  system("pwd")
  puts StringInFile.present("rake", "/home/vagrant/shared/generic_app/tmp/setup.sh")
  expect(StringInFile.present("rake", "/home/vagrant/shared/generic_app/tmp/setup.sh")).to eq(true)
end

def setup
  cd_dir_execute("tmp", "sh setup.sh")
end
