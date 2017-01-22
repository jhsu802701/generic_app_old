require 'spec_helper'
require 'generic_app'
require 'string_in_file'

dir_app_1 = "#{ENV['DIR_PARENT']}/tmp1"

describe GenericApp do
  it 'New Rails app' do
    puts
    puts '**************'
    puts 'CREATING APP 1'
    puts 'New Rails app'
    system("rm -rf #{dir_app_1}")
    Dir.chdir(ENV['DIR_PARENT']) do
      GenericApp.create_new('tmp1', '007@railstutorial.org')
    end
  end

  it 'Email address should be updated' do
    expect(StringInFile.present('007@railstutorial.org', "#{dir_app_1}/config/initializers/devise.rb")).to eq(true)
    expect(StringInFile.present('007@railstutorial.org', "#{dir_app_1}/app/views/static_pages/contact.html.erb")).to eq(true)
  end

  it 'Bash scripts should be provided' do
    expect(StringInFile.present('heroku run rake db:migrate', "#{dir_app_1}/heroku_upload.sh")).to eq(true)
    expect(StringInFile.present('pkill', "#{dir_app_1}/kill_spring.sh")).to eq(true)
    expect(StringInFile.present('tree app/controllers', "#{dir_app_1}/outline.sh")).to eq(true)
    expect(StringInFile.present('rails console --sandbox', "#{dir_app_1}/sandbox.sh")).to eq(true)
    expect(StringInFile.present('rake db:seed', "#{dir_app_1}/seed.sh")).to eq(true)
    expect(StringInFile.present('rails server -b 0.0.0.0', "#{dir_app_1}/server.sh")).to eq(true)
    expect(StringInFile.present('bundle install', "#{dir_app_1}/build_fast.sh")).to eq(true)
  end

  it 'New README.md file should be provided' do
    expect(StringInFile.present('outline.sh', "#{dir_app_1}/README.md")).to eq(true)
  end

  it 'Guardfile should be set to automatically run tests upon startup' do
    expect(StringInFile.present('all_on_start: true', "#{dir_app_1}/Guardfile")).to eq(true)
  end

  it 'The .gitignore file includes tmp, tmp*, and ,DS_Store' do
    expect(StringInFile.present('tmp', "#{dir_app_1}/.gitignore")).to eq(true)
    expect(StringInFile.present('tmp*', "#{dir_app_1}/.gitignore")).to eq(true)
    expect(StringInFile.present('.DS_Store', "#{dir_app_1}/.gitignore")).to eq(true)
    expect(StringInFile.present('notes/*.dot', "#{dir_app_1}/.gitignore")).to eq(true)
    expect(StringInFile.present('notes/*.svg', "#{dir_app_1}/.gitignore")).to eq(true)
    expect(StringInFile.present('gemsurance_report.html', "#{dir_app_1}/.gitignore")).to eq(true)
  end

  it 'The notes/1-file_list-controllers.txt file should be in place' do
    expect(StringInFile.present('users_controller_test.rb', "#{dir_app_1}/notes/1-file_list-controllers.txt")).to eq(true)
    expect(StringInFile.present('users_controller.rb', "#{dir_app_1}/notes/1-file_list-controllers.txt")).to eq(true)
    expect(StringInFile.present('confirmations_controller.rb', "#{dir_app_1}/notes/1-file_list-controllers.txt")).to eq(true)
    expect(StringInFile.present('omniauth_callbacks_controller.rb', "#{dir_app_1}/notes/1-file_list-controllers.txt")).to eq(true)
    expect(StringInFile.present('passwords_controller.rb', "#{dir_app_1}/notes/1-file_list-controllers.txt")).to eq(true)
    expect(StringInFile.present('registrations_controller.rb', "#{dir_app_1}/notes/1-file_list-controllers.txt")).to eq(true)
    expect(StringInFile.present('sessions_controller.rb', "#{dir_app_1}/notes/1-file_list-controllers.txt")).to eq(true)
    expect(StringInFile.present('unlocks_controller.rb', "#{dir_app_1}/notes/1-file_list-controllers.txt")).to eq(true)
  end

  it 'The notes/1-file_list-misc.txt file should be in place' do
    expect(StringInFile.present('application_helper.rb', "#{dir_app_1}/notes/1-file_list-helpers.txt")).to eq(true)
  end

  it 'The notes/1-file_list-models.txt file should be in place' do
    expect(StringInFile.present('admin_test.rb', "#{dir_app_1}/notes/1-file_list-models.txt")).to eq(true)
    expect(StringInFile.present('user_test.rb', "#{dir_app_1}/notes/1-file_list-models.txt")).to eq(true)
    expect(StringInFile.present('admin.rb', "#{dir_app_1}/notes/1-file_list-models.txt")).to eq(true)
    expect(StringInFile.present('user.rb', "#{dir_app_1}/notes/1-file_list-models.txt")).to eq(true)
  end
end
