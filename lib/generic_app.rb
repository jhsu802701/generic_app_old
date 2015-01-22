require "generic_app/version"

module GenericApp
  def self.create
    puts "DEFAULT VALUE: sample_app_3rd_edition"
    puts "Enter the directory name you wish to use for your generic app:"
    subdir_name = gets.chomp
    system("git clone https://github.com/mhartl/sample_app_3rd_edition.git #{subdir_name}")
    system("cd #{subdir_name} && git checkout remotes/origin/account-activation-password-reset")
    system ("cd #{subdir_name} && git init")
  end
end
