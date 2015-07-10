require 'spec_helper'
require 'generic_app'
require 'string_in_file'

dir_app_5 = "#{ENV['DIR_PARENT']}/tmp5"

describe GenericApp do
  it "Adding scripts to an existing app should work" do
    puts
    puts '**********'
    puts 'TEST APP 5'
    puts 'Testing the addition of scripts to an existing SQLite-based Rails app'
    
    system("rm -rf #{dir_app_5}")
    
    Dir.chdir("#{ENV['DIR_PARENT']}") do
      t1 = Thread.new {
        system("git clone https://github.com/mhartl/sample_app_3rd_edition.git tmp5")
        GenericApp.add_sq ('tmp5')
      }
      t1.join
      n = (Time.now.to_i ) * 3
      GenericApp.add_pg('tmp5', "db_tmp5_#{n}", "eu_tmp5_#{n}", "ep_tmp5_#{n}", "u_tmp5_#{n}", 'abcdef')
    end
  end

  it "Bash scripts should be provided" do
    expect(StringInFile.present("heroku run rake db:migrate", "#{dir_app_5}/heroku_upload.sh")).to eq(true)
    expect(StringInFile.present("pkill", "#{dir_app_5}/kill_spring.sh")).to eq(true)
    expect(StringInFile.present("ls -R1 -I concerns app/controllers", "#{dir_app_5}/list_files.sh")).to eq(true)
    expect(StringInFile.present("rails console --sandbox", "#{dir_app_5}/sandbox.sh")).to eq(true)
    expect(StringInFile.present("rake db:seed", "#{dir_app_5}/seed.sh")).to eq(true)
    expect(StringInFile.present("rails server -b 0.0.0.0", "#{dir_app_5}/server.sh")).to eq(true)
    expect(StringInFile.present("bundle install", "#{dir_app_5}/test_app.sh")).to eq(true)
  end

  it "The .gitignore file includes tmp, tmp*, and ,DS_Store" do
    expect(StringInFile.present("tmp", "#{dir_app_5}/.gitignore")).to eq(true)
    expect(StringInFile.present("tmp*", "#{dir_app_5}/.gitignore")).to eq(true)
    expect(StringInFile.present(".DS_Store", "#{dir_app_5}/.gitignore")).to eq(true)
  end
end
