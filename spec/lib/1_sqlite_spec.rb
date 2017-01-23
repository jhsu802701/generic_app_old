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
      GenericApp.create_new('tmp1', '007@railstutorial.org')
    end
  end

  it 'Email address should be updated' do
    expect(StringInFile.present('007@railstutorial.org', "#{dir_app_1}/config/initializers/devise.rb")).to eq(true)
    expect(StringInFile.present('007@railstutorial.org', "#{dir_app_1}/app/views/static_pages/contact.html.erb")).to eq(true)
  end

  it 'Badges should be removed from README.md' do
    expect(StringInFile.present('continuous integration badges', "#{dir_app_1}/README.md")).to eq(false)
    expect(StringInFile.present('[CircleCI]', "#{dir_app_1}/README.md")).to eq(false)
    expect(StringInFile.present('[Dependency Status]', "#{dir_app_1}/README.md")).to eq(false)
    expect(StringInFile.present('[security]', "#{dir_app_1}/README.md")).to eq(false)
    expect(StringInFile.present('[Code Climate]', "#{dir_app_1}/README.md")).to eq(false)
  end

  it 'New README.md file should be provided' do
    expect(StringInFile.present('Generic App Template', "#{dir_app_1}/README.md")).to eq(true)
  end
end
