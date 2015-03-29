require 'spec_helper'
require 'generic_app'
require 'string_in_file'

describe GenericApp do  
  it "PostgreSQL version works with changed parameters" do
    puts "************************************************************************************"
    puts "Testing the PostgreSQL procedure given new databases, a new user, and a new password"
    puts "Copying the PostgreSQL-based Rails app previously created."
    system("rm -rf tmp3")
    system("cp -rf tmp2 tmp3")
    
    n = (Time.now.to_i ) * 2
    
    GenericApp.set_pg_params("tmp3", "db_tmp3_#{n}", "eu_tmp3_#{n}", "ep_tmp3_#{n}", "u_tmp3_#{n}", "fedcba")
    
    expect(StringInFile.present("sqlite", "tmp3/Gemfile")).to eq(false)
    expect(StringInFile.present("gem 'pg'", "tmp3/Gemfile")).to eq(true)
    expect(StringInFile.present("u_tmp3_#{n}", "tmp3/config/application.yml")).to eq(true)
    expect(StringInFile.present("fedcba", "tmp3/config/application.yml")).to eq(true)
    expect(StringInFile.present("eu_tmp3_#{n}", "tmp3/config/application.yml")).to eq(true)
    expect(StringInFile.present("ep_tmp3_#{n}", "tmp3/config/application.yml")).to eq(true)
    expect(StringInFile.present("db_tmp3_#{n}_dev", "tmp3/config/database.yml")).to eq(true)
    expect(StringInFile.present("db_tmp3_#{n}_test", "tmp3/config/database.yml")).to eq(true)
    expect(StringInFile.present("db_tmp3_#{n}_pro", "tmp3/config/database.yml")).to eq(true)
    expect(StringInFile.present("eu_tmp3_#{n}", "tmp3/config/database.yml")).to eq(true)
    expect(StringInFile.present("ep_tmp3_#{n}", "tmp3/config/database.yml")).to eq(true)
  end
end

