require 'spec_helper'
require 'generic_app'
require 'string_in_file'

dir_parent = File.expand_path('../../../../', __FILE__)
dir_app_1 = "#{dir_parent}/tmp1"

describe GenericApp do
  it 'New Rails app' do
    puts
    puts '**************'
    puts 'CREATING APP 1'
    puts 'New Rails app'
    system("rm -rf #{dir_app_1}")
    Dir.chdir(dir_parent) do
      GenericApp.create_new('tmp1', '007@railstutorial.org', 'Your New App')
    end
  end

  it 'config/heroku_name.txt should be removed' do
    expect(File.exist?("#{dir_app_1}/config/heroku_name.txt")).to eq(false)
  end

  it 'Email address should be updated' do
    expect(StringInFile.present('007@railstutorial.org', "#{dir_app_1}/config/initializers/devise.rb")).to eq(true)
    expect(StringInFile.present('007@railstutorial.org', "#{dir_app_1}/app/views/static_pages/contact.html.erb")).to eq(true)
    expect(StringInFile.present('007@railstutorial.org', "#{dir_app_1}/test/integration/static_pages_test.rb")).to eq(true)
  end

  it 'Badges should be removed from README.md' do
    expect(StringInFile.present('continuous integration badges', "#{dir_app_1}/README.md")).to eq(false)
    expect(StringInFile.present('[CircleCI]', "#{dir_app_1}/README.md")).to eq(false)
    expect(StringInFile.present('[Dependency Status]', "#{dir_app_1}/README.md")).to eq(false)
    expect(StringInFile.present('[security]', "#{dir_app_1}/README.md")).to eq(false)
    expect(StringInFile.present('[Code Climate]', "#{dir_app_1}/README.md")).to eq(false)
  end

  it 'The specified app title should be provided in place of "Generic App Template"' do
    array_files = []
    array_files << "#{dir_app_1}/README.md"
    array_files << "#{dir_app_1}/app/helpers/application_helper.rb"
    array_files << "#{dir_app_1}/app/views/layouts/_header.html.erb"
    array_files << "#{dir_app_1}/app/views/layouts/_footer.html.erb"
    array_files << "#{dir_app_1}/app/views/static_pages/home.html.erb"
    array_files << "#{dir_app_1}/test/helpers/application_helper_test.rb"
    array_files << "#{dir_app_1}/test/integration/static_pages_test.rb"

    array_files.each do |f|
      expect(StringInFile.present('Generic App Template', f)).to eq(false)
      expect(StringInFile.present('GENERIC APP TEMPLATE', f)).to eq(false)
      expect(StringInFile.present('Your New App', f)).to eq(true)
    end
  end
end
