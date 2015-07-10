require 'spec_helper'
require 'generic_app'
require 'string_in_file'

dir_app_4 = "#{ENV['DIR_PARENT']}/tmp4"

describe GenericApp do
  it 'Legacy app with SQLite' do
    puts
    puts '**********'
    puts 'TEST APP 4'
    puts 'Legacy app with SQLite'

    system("rm -rf #{dir_app_4}")
    Dir.chdir("#{ENV['DIR_PARENT']}") do
      t1 = Thread.new {
        system("git clone https://github.com/mhartl/sample_app_3rd_edition.git tmp4")
      }
      t1.join
      GenericApp.add_sq ('tmp4')
    end
  end

  it "Bash scripts should be provided" do
    expect(StringInFile.present("heroku run rake db:migrate", "#{dir_app_4}/heroku_upload.sh")).to eq(true)
    expect(StringInFile.present("pkill", "#{dir_app_4}/kill_spring.sh")).to eq(true)
    expect(StringInFile.present("ls -R1 -I concerns app/controllers", "#{dir_app_4}/list_files.sh")).to eq(true)
    expect(StringInFile.present("rails console --sandbox", "#{dir_app_4}/sandbox.sh")).to eq(true)
    expect(StringInFile.present("rake db:seed", "#{dir_app_4}/seed.sh")).to eq(true)
    expect(StringInFile.present("rails server -b 0.0.0.0", "#{dir_app_4}/server.sh")).to eq(true)
    expect(StringInFile.present("bundle install", "#{dir_app_4}/test_app.sh")).to eq(true)
  end

  it "The .gitignore file includes tmp, tmp*, and ,DS_Store" do
    expect(StringInFile.present("tmp", "#{dir_app_4}/.gitignore")).to eq(true)
    expect(StringInFile.present("tmp*", "#{dir_app_4}/.gitignore")).to eq(true)
    expect(StringInFile.present(".DS_Store", "#{dir_app_4}/.gitignore")).to eq(true)
  end
end
