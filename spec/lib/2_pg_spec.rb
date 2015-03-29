require 'spec_helper'
require 'generic_app'
require 'string_in_file'

describe GenericApp do  
  it "PostgreSQL version should execute" do
    puts "********************************"
    puts "Testing the PostgreSQL procedure"
    puts "Clearing space for Rails tutorial"
    system("rm -rf tmp2")
    
    n = Time.now.to_i
    
    GenericApp.pg("tmp2", "db_tmp2_#{n}", "eu_tmp2_#{n}", "ep_tmp2_#{n}", "u_tmp2_#{n}", "abcdef")
    
    GenericApp.git_init("tmp2")
    
    expect(StringInFile.present("sqlite", "tmp2/Gemfile")).to eq(false)
    expect(StringInFile.present("gem 'pg'", "tmp2/Gemfile")).to eq(true)
  end
  
end

