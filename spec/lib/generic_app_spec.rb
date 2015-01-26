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
      generic_app = GenericApp.new
      generic_app.create("tmp")
     }
    t1.join

    t1 = Thread.new { 
      puts "\nChecking Bash scripts"      
      expect(StringInFile.present("heroku run rake db:migrate", "tmp/heroku_upload.sh")).to eq(true)
      expect(StringInFile.present("pkill", "tmp/kill_spring.sh")).to eq(true)
      expect(StringInFile.present("ls -R1 -I concerns app/controllers", "tmp/list_files.sh")).to eq(true)
      expect(StringInFile.present("rails console --sandbox", "tmp/sandbox.sh")).to eq(true)
      expect(StringInFile.present("rake db:seed", "tmp/seed.sh")).to eq(true)
      expect(StringInFile.present("rails server -b 0.0.0.0", "tmp/server.sh")).to eq(true)
      expect(StringInFile.present("bundle install", "tmp/setup.sh")).to eq(true)

      puts "\nChecking README.md"
      expect(StringInFile.present("list_files.sh", "tmp/README.md")).to eq(true)

      puts "\nChecking Guardfile"
      expect(StringInFile.present("all_on_start: true", "tmp/Guardfile")).to eq(true)
      
      
      puts "\nChecking for suggestion to use password management software"
      expect(StringInFile.present("KeePassX", "tmp/app/views/users/new.html.erb")).to eq(true)
      expect(StringInFile.present("KeePassX", "tmp/app/views/users/edit.html.erb")).to eq(true)
      expect(StringInFile.present("KeePassX", "tmp/app/views/password_resets/new.html.erb")).to eq(true)
      expect(StringInFile.present("KeePassX", "tmp/app/views/password_resets/edit.html.erb")).to eq(true)
     }
    t1.join
    
  end
end

