require 'spec_helper'
require 'generic_app'
require 'string_in_file'

describe GenericApp do
  
  it "Adding scripts to an existing app should work" do
    puts
    puts "********************************************************"
    puts "Testing the addition of scripts to an existing Rails app"
    system("rm -rf tmp4")
    t1 = Thread.new {
      system("git clone https://github.com/mhartl/sample_app_3rd_edition.git tmp4")
    }
    t1.join
    GenericApp.add_scripts ("tmp4")
    GenericApp.update_gitignore ("tmp4")
  end
  
  it "Bash scripts should be provided" do
    expect(StringInFile.present("heroku run rake db:migrate", "tmp4/heroku_upload.sh")).to eq(true)
    expect(StringInFile.present("pkill", "tmp4/kill_spring.sh")).to eq(true)
    expect(StringInFile.present("ls -R1 -I concerns app/controllers", "tmp4/list_files.sh")).to eq(true)
    expect(StringInFile.present("rails console --sandbox", "tmp4/sandbox.sh")).to eq(true)
    expect(StringInFile.present("rake db:seed", "tmp4/seed.sh")).to eq(true)
    expect(StringInFile.present("rails server -b 0.0.0.0", "tmp4/server.sh")).to eq(true)
    expect(StringInFile.present("bundle install", "tmp4/test.sh")).to eq(true)
  end
  
  it "The .gitignore file includes tmp, tmp*, and ,DS_Store" do
    expect(StringInFile.present("tmp", "tmp4/.gitignore")).to eq(true)
    expect(StringInFile.present("tmp*", "tmp4/.gitignore")).to eq(true)
    expect(StringInFile.present(".DS_Store", "tmp4/.gitignore")).to eq(true)
  end
  
  it "The notes/1-file_list.txt file should be in place" do
    expect(StringInFile.present("app/models", "tmp4/notes/1-file_list.txt")).to eq(true)
    expect(StringInFile.present("app/views", "tmp4/notes/1-file_list.txt")).to eq(true)
    expect(StringInFile.present("app/controllers", "tmp4/notes/1-file_list.txt")).to eq(true)
  end
  
end

