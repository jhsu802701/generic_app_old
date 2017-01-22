require 'spec_helper'
require 'generic_app'
require 'string_in_file'

ENV['DIR_MAIN'] = File.expand_path('../../', __FILE__)
ENV['DIR_PARENT'] = File.expand_path('../../../', __FILE__)
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

  it 'New README.md file should be provided' do
    expect(StringInFile.present('outline.sh', "#{dir_app_1}/README.md")).to eq(true)
  end
end
