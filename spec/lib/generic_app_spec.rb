require 'spec_helper'
require 'generic_app'
require 'string_in_file'

describe GenericApp do
  it "should copy the Rails tutorial" do
    puts "*********************************"
    puts "Clearing space for Rails tutorial"
    system("rm -rf tmp1")
    GenericApp.sq("tmp1")
    GenericApp.git_init("tmp1")
    
  end
  
  it "Bash scripts should be provided" do
    expect(StringInFile.present("heroku run rake db:migrate", "tmp1/heroku_upload.sh")).to eq(true)
    expect(StringInFile.present("pkill", "tmp1/kill_spring.sh")).to eq(true)
    expect(StringInFile.present("ls -R1 -I concerns app/controllers", "tmp1/list_files.sh")).to eq(true)
    expect(StringInFile.present("rails console --sandbox", "tmp1/sandbox.sh")).to eq(true)
    expect(StringInFile.present("rake db:seed", "tmp1/seed.sh")).to eq(true)
    expect(StringInFile.present("rails server -b 0.0.0.0", "tmp1/server.sh")).to eq(true)
    expect(StringInFile.present("bundle install", "tmp1/test.sh")).to eq(true)
  end
  
  it "New README.md file should be provided" do
    expect(StringInFile.present("list_files.sh", "tmp1/README.md")).to eq(true)
  end
  
  it "Guardfile should be set to automatically run tests upon startup" do
    expect(StringInFile.present("all_on_start: true", "tmp1/Guardfile")).to eq(true)
  end
  
  it "Suggestions to use password management software should be provided" do
    expect(StringInFile.present("KeePassX", "tmp1/app/views/users/new.html.erb")).to eq(true)
    expect(StringInFile.present("KeePassX", "tmp1/app/views/users/edit.html.erb")).to eq(true)
    expect(StringInFile.present("KeePassX", "tmp1/app/views/password_resets/new.html.erb")).to eq(true)
    expect(StringInFile.present("KeePassX", "tmp1/app/views/password_resets/edit.html.erb")).to eq(true)
  end
  
  it "The .gitignore file includes tmp, tmp*, and ,DS_Store" do
    expect(StringInFile.present("tmp", "tmp1/.gitignore")).to eq(true)
    expect(StringInFile.present("tmp*", "tmp1/.gitignore")).to eq(true)
    expect(StringInFile.present(".DS_Store", "tmp1/.gitignore")).to eq(true)
  end
  
  it "The notes/1-file_list.txt file should be in place" do
    expect(StringInFile.present("app/models", "tmp1/notes/1-file_list.txt file")).to eq(true)
    expect(StringInFile.present("app/views", "tmp1/notes/1-file_list.txt file")).to eq(true)
    expect(StringInFile.present("app/controllers", "tmp1/notes/1-file_list.txt file")).to eq(true)
  end
  
  it "The notes/mvc-users.txt file should be in place" do
    expect(StringInFile.present("app/controllers/users_controller.rb", "tmp1/notes/1-file_list.txt file")).to eq(true)
    expect(StringInFile.present("test/controllers/users_controller_test.rb", "tmp1/notes/1-file_list.txt file")).to eq(true)
    expect(StringInFile.present("app/helpers/users_helper.rb", "tmp1/notes/1-file_list.txt file")).to eq(true)
    expect(StringInFile.present("def index", "tmp1/notes/1-file_list.txt file")).to eq(true)
    expect(StringInFile.present("def show", "tmp1/notes/1-file_list.txt file")).to eq(true)
  end
  
end

