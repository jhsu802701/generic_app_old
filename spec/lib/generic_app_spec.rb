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
      GenericApp.create("tmp")
     }
    t1.join

  end
  
  it "Bash scripts should be provided" do
    expect(StringInFile.present("heroku run rake db:migrate", "tmp/heroku_upload.sh")).to eq(true)
    expect(StringInFile.present("pkill", "tmp/kill_spring.sh")).to eq(true)
    expect(StringInFile.present("ls -R1 -I concerns app/controllers", "tmp/list_files.sh")).to eq(true)
    expect(StringInFile.present("rails console --sandbox", "tmp/sandbox.sh")).to eq(true)
    expect(StringInFile.present("rake db:seed", "tmp/seed.sh")).to eq(true)
    expect(StringInFile.present("rails server -b 0.0.0.0", "tmp/server.sh")).to eq(true)
    expect(StringInFile.present("bundle install", "tmp/test.sh")).to eq(true)
  end
  
  it "New README.md file should be provided" do
    expect(StringInFile.present("list_files.sh", "tmp/README.md")).to eq(true)
  end
  
  it "Guardfile should be set to automatically run tests upon startup" do
    expect(StringInFile.present("all_on_start: true", "tmp/Guardfile")).to eq(true)
  end
  
  it "Suggestions to use password management software should be provided" do
    expect(StringInFile.present("KeePassX", "tmp/app/views/users/new.html.erb")).to eq(true)
    expect(StringInFile.present("KeePassX", "tmp/app/views/users/edit.html.erb")).to eq(true)
    expect(StringInFile.present("KeePassX", "tmp/app/views/password_resets/new.html.erb")).to eq(true)
    expect(StringInFile.present("KeePassX", "tmp/app/views/password_resets/edit.html.erb")).to eq(true)
  end
  
  it "The .gitignore file includes tmp, tmp*, and ,DS_Store" do
    expect(StringInFile.present("tmp", "tmp/.gitignore")).to eq(true)
    expect(StringInFile.present("tmp*", "tmp/.gitignore")).to eq(true)
    expect(StringInFile.present(".DS_Store", "tmp/.gitignore")).to eq(true)
  end
end

