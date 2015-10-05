require 'spec_helper'
require 'generic_app'
require 'string_in_file'

dir_app_2 = "#{ENV['DIR_PARENT']}/tmp2"

describe GenericApp do
  it 'Legacy app' do
    puts
    puts '**************'
    puts 'STARTING APP 2'
    puts 'Legacy Rails app'

    system("rm -rf #{dir_app_2}")
    Dir.chdir("#{ENV['DIR_PARENT']}") do
      t1 = Thread.new {
        puts '------------------'
        puts 'Getting legacy app'
        system('git clone https://github.com/mhartl/sample_app_3rd_edition.git tmp2')
        system('wait')
        system("cd tmp2 && git checkout remotes/origin/account-activation-password-reset")
        system('wait')
        puts 'Finished acquiring legacy app'
        puts '-----------------------------'
      }
      t1.join
      GenericApp.add ('tmp2')
    end
  end

  it "Bash scripts should be provided" do
    expect(StringInFile.present("heroku run rake db:migrate", "#{dir_app_2}/heroku_upload.sh")).to eq(true)
    expect(StringInFile.present("pkill", "#{dir_app_2}/kill_spring.sh")).to eq(true)
    expect(StringInFile.present("ls -R1 -I concerns app/controllers", "#{dir_app_2}/outline.sh")).to eq(true)
    expect(StringInFile.present("rails console --sandbox", "#{dir_app_2}/sandbox.sh")).to eq(true)
    expect(StringInFile.present("rake db:seed", "#{dir_app_2}/seed.sh")).to eq(true)
    expect(StringInFile.present("rails server -b 0.0.0.0", "#{dir_app_2}/server.sh")).to eq(true)
    expect(StringInFile.present("bundle install", "#{dir_app_2}/test_app.sh")).to eq(true)
  end

  it "The .gitignore file includes tmp, tmp*, and ,DS_Store" do
    expect(StringInFile.present("tmp", "#{dir_app_2}/.gitignore")).to eq(true)
    expect(StringInFile.present("tmp*", "#{dir_app_2}/.gitignore")).to eq(true)
    expect(StringInFile.present(".DS_Store", "#{dir_app_2}/.gitignore")).to eq(true)
    expect(StringInFile.present("notes/*.dot", "#{dir_app_2}/.gitignore")).to eq(true)
    expect(StringInFile.present("notes/*.svg", "#{dir_app_2}/.gitignore")).to eq(true)
    expect(StringInFile.present("gemsurance_report.html", "#{dir_app_2}/.gitignore")).to eq(true)
  end

  it "The Gemfile includes code checking gems" do
    expect(StringInFile.present("gem 'sandi_meter'", "#{dir_app_2}/Gemfile")).to eq(true)
    expect(StringInFile.present("gem 'brakeman'", "#{dir_app_2}/Gemfile")).to eq(true)
    expect(StringInFile.present("gem 'bundler-audit'", "#{dir_app_2}/Gemfile")).to eq(true)
    expect(StringInFile.present("gem 'rails-erd'", "#{dir_app_2}/Gemfile")).to eq(true)
    expect(StringInFile.present("gem 'railroady'", "#{dir_app_2}/Gemfile")).to eq(true)
    expect(StringInFile.present("gem 'annotate'", "#{dir_app_2}/Gemfile")).to eq(true)
    expect(StringInFile.present("gem 'gemsurance'", "#{dir_app_2}/Gemfile")).to eq(true)
  end
  
  it 'The test_code.sh script excludes certain parts of the original' do
    expect(StringInFile.present('***', "#{dir_app_2}/test_code.sh")).to eq(false)
    expect(StringInFile.present('rubocop', "#{dir_app_2}/test_code.sh")).to eq(false)
    expect(StringInFile.present('rails_best_practices', "#{dir_app_2}/test_code.sh")).to eq(false)
    expect(StringInFile.present('metric_fu', "#{dir_app_2}/test_code.sh")).to eq(false)
  end
end
