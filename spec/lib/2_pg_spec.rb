require 'spec_helper'
require 'generic_app'
require 'string_in_file'

dir_app_2 = "#{ENV['DIR_PARENT']}/tmp2"

describe GenericApp do  
  it "New Rails app with PostgreSQL" do
    puts
    puts '**********'
    puts 'TEST APP 2'
    puts 'New Rails app with PostgreSQL'
    system("rm -rf #{dir_app_2}")
    n = Time.now.to_i
    Dir.chdir("#{ENV['DIR_PARENT']}") do
      GenericApp.pg("tmp2", "db_tmp2_#{n}", "eu_tmp2_#{n}", "ep_tmp2_#{n}", "u_tmp2_#{n}", "abcdef")
    end    
  end
  
  it "Bash scripts should be provided" do
    expect(StringInFile.present("heroku run rake db:migrate", "#{dir_app_2}/heroku_upload.sh")).to eq(true)
    expect(StringInFile.present("pkill", "#{dir_app_2}/kill_spring.sh")).to eq(true)
    expect(StringInFile.present("ls -R1 -I concerns app/controllers", "#{dir_app_2}/list_files.sh")).to eq(true)
    expect(StringInFile.present("rails console --sandbox", "#{dir_app_2}/sandbox.sh")).to eq(true)
    expect(StringInFile.present("rake db:seed", "#{dir_app_2}/seed.sh")).to eq(true)
    expect(StringInFile.present("rails server -b 0.0.0.0", "#{dir_app_2}/server.sh")).to eq(true)
    expect(StringInFile.present("bundle install", "#{dir_app_2}/test_app.sh")).to eq(true)
  end
  
  it "New README.md file should be provided" do
    expect(StringInFile.present("list_files.sh", "#{dir_app_2}/README.md")).to eq(true)
  end
  
  it "Guardfile should be set to automatically run tests upon startup" do
    expect(StringInFile.present("all_on_start: true", "#{dir_app_2}/Guardfile")).to eq(true)
  end
  
  it "The .gitignore file includes tmp, tmp*, and ,DS_Store" do
    expect(StringInFile.present("tmp", "#{dir_app_2}/.gitignore")).to eq(true)
    expect(StringInFile.present("tmp*", "#{dir_app_2}/.gitignore")).to eq(true)
    expect(StringInFile.present(".DS_Store", "#{dir_app_2}/.gitignore")).to eq(true)
  end
  
  it "The notes/1-file_list.txt file should be in place" do
    expect(StringInFile.present("app/models", "#{dir_app_2}/notes/1-file_list.txt")).to eq(true)
    expect(StringInFile.present("app/views", "#{dir_app_2}/notes/1-file_list.txt")).to eq(true)
    expect(StringInFile.present("app/controllers", "#{dir_app_2}/notes/1-file_list.txt")).to eq(true)
  end
  
  it "The notes/mvc-users.txt file should be in place" do
    expect(StringInFile.present("users_controller.rb", "#{dir_app_2}/notes/mvc-users.txt")).to eq(true)
    expect(StringInFile.present("users_controller_test.rb", "#{dir_app_2}/notes/mvc-users.txt")).to eq(true)
    expect(StringInFile.present("users_helper.rb", "#{dir_app_2}/notes/mvc-users.txt")).to eq(true)
    expect(StringInFile.present("def index", "#{dir_app_2}/notes/mvc-users.txt")).to eq(true)
    expect(StringInFile.present("def show", "#{dir_app_2}/notes/mvc-users.txt")).to eq(true)
  end
end
