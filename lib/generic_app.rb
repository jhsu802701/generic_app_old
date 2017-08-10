require 'generic_app/version'
require 'string_in_file'
require 'line_containing'
require 'remove_double_blank'

DIR_MAIN = File.expand_path('../../', __FILE__)
DIR_PARENT = File.expand_path('../../../', __FILE__)

#
module GenericApp
  # Create app, stick with SQLite database in development
  def self.create_new(subdir_name, email, title)
    t1 = Thread.new { self.git_clone(subdir_name) }
    t1.join
    self.remove_neutrino(subdir_name)
    self.remove_heroku_name(subdir_name)
    self.email_update(subdir_name, email)
    self.remove_badges(subdir_name)
    self.update_titles(subdir_name, title)
    self.git_init(subdir_name)
  end

  def self.remove_heroku_name(subdir_name)
    File.delete("#{subdir_name}/config/heroku_name.txt")
  end

  def self.remove_neutrino(subdir_name)
    File.delete("#{subdir_name}/neutrino.sh")
  end

  def self.git_clone(subdir_name)
    puts '-------------------------------------------'
    puts 'Getting the URL of the Generic App Template'
    system('git clone https://github.com/jhsu802701/generic_app_template_url.git')
    url_template = StringInFile.read('generic_app_template_url/rails5.txt')
    system('rm -rf generic_app_template_url')
    puts '------------------------------------'
    puts 'Downloading the Generic App Template'
    system("git clone #{url_template} #{subdir_name}")
  end

  def self.email_update(subdir_name, email)
    email_orig = 'somebody@rubyonracetracks.com'
    path_of_email_1 = "#{subdir_name}/config/initializers/devise.rb"
    path_of_email_2 = "#{subdir_name}/app/views/static_pages/contact.html.erb"
    path_of_email_3 = "#{subdir_name}/test/integration/static_pages_test.rb"
    StringInFile.replace(email_orig, email, path_of_email_1)
    StringInFile.replace(email_orig, email, path_of_email_2)
    StringInFile.replace(email_orig, email, path_of_email_3)
  end

  def self.remove_badges(subdir_name)
    path_readme = "#{subdir_name}/README.md"
    LineContaining.delete('[![CircleCI](https://circleci.com', path_readme)
    LineContaining.delete('[![Dependency Status](https://gemnasium.com', path_readme)
    LineContaining.delete('[![security](https://hakiri.io', path_readme)
    LineContaining.delete('[![Code Climate](https://codeclimate.com', path_readme)
    RemoveDoubleBlank.update(path_readme)
  end

  def self.update_titles(subdir_name, title)
    array_files = []
    array_files << "#{subdir_name}/README.md"
    array_files << "#{subdir_name}/app/helpers/application_helper.rb"
    array_files << "#{subdir_name}/app/views/layouts/_header.html.erb"
    array_files << "#{subdir_name}/app/views/layouts/_footer.html.erb"
    array_files << "#{subdir_name}/app/views/static_pages/home.html.erb"
    array_files << "#{subdir_name}/test/helpers/application_helper_test.rb"
    array_files << "#{subdir_name}/test/integration/static_pages_test.rb"

    array_files.each do |f|
      StringInFile.replace('Generic App Template', title, f)
      StringInFile.replace('GENERIC APP TEMPLATE', title, f)
    end
  end

  def self.git_init(subdir_name)
    puts '-----------------------'
    puts 'Removing old Git record'
    system("cd #{subdir_name} && rm -rf .git")
    system("cd #{subdir_name} && git init")
    system("cd #{subdir_name} && git add .")
  end
end
