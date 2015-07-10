require 'spec_helper'
require 'generic_app'
require 'string_in_file'

dir_app_3 = "#{ENV['DIR_PARENT']}/tmp3"

describe GenericApp do  
  it "Test App 2 with new parameters" do
    puts
    puts '**********'
    puts 'TEST APP 3'
    puts 'Test App 2 with a new database, a new user, and a new password'
    puts
    puts "Copying the PostgreSQL-based Rails app previously created."
    system("rm -rf #{dir_app_3}")
    n = (Time.now.to_i ) * 2
    Dir.chdir("#{ENV['DIR_PARENT']}") do
      t1 = Thread.new {
        system("cp -rf tmp2 tmp3")
      }
      t1.join
      GenericApp.set_pg_params('tmp3', "db_tmp3_#{n}", "eu_tmp3_#{n}", "ep_tmp3_#{n}", "u_tmp3_#{n}", 'fedcba')
    end  

    expect(StringInFile.present("sqlite", "#{dir_app_3}/Gemfile")).to eq(false)
    expect(StringInFile.present("gem 'pg'", "#{dir_app_3}/Gemfile")).to eq(true)
    expect(StringInFile.present("u_tmp3_#{n}", "#{dir_app_3}/config/application.yml")).to eq(true)
    expect(StringInFile.present("fedcba", "#{dir_app_3}/config/application.yml")).to eq(true)
    expect(StringInFile.present("eu_tmp3_#{n}", "#{dir_app_3}/config/application.yml")).to eq(true)
    expect(StringInFile.present("ep_tmp3_#{n}", "#{dir_app_3}/config/application.yml")).to eq(true)
    expect(StringInFile.present("db_tmp3_#{n}_dev", "#{dir_app_3}/config/database.yml")).to eq(true)
    expect(StringInFile.present("db_tmp3_#{n}_test", "#{dir_app_3}/config/database.yml")).to eq(true)
    expect(StringInFile.present("db_tmp3_#{n}_pro", "#{dir_app_3}/config/database.yml")).to eq(true)
    expect(StringInFile.present("eu_tmp3_#{n}", "#{dir_app_3}/config/database.yml")).to eq(true)
    expect(StringInFile.present("ep_tmp3_#{n}", "#{dir_app_3}/config/database.yml")).to eq(true)
  end
end
