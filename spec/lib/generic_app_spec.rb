require 'spec_helper'
require 'generic_app'

describe GenericApp do
  it "should copy the Rails tutorial" do
    system("rm -rf tmp")
    generic_app = GenericApp.new
    generic_app.create("tmp")
  end
end

def cd_dir_execute (dir_cd, command)
  system ("cd #{dir_cd} && #{command}")
end
