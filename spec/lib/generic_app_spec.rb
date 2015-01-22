require 'spec_helper'
require 'generic_app'

describe GenericApp do
  dir_home = `echo $HOME`.strip # /home/<username>
  dir_test_parent = "#{dir_home}/test_gem" # /home/<username>/test_gem
  system("mkdir #{dir_test_parent}")
  
  it "should clone the Rails tutorial - all mode" do
    cd_dir_execute(dir_test_parent, "rm -rf test_all")
    cd_dir_execute(dir_test_parent, "generic_app")
    input1 = String.new
    input1.stub!(:gets).and_return("test1\n")
  end
end

def cd_dir_execute (dir_cd, command)
  system ("cd #{dir_cd} && #{command}")
end
