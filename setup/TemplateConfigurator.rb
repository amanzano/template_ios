# modified from CocoaPods lib template
# https://github.com/CocoaPods/pod-template

require 'colored'

module Vivant
  class TemplateConfigurator

    attr_reader :pod_name, :pods_for_podfile, :prefixes, :test_example_file, :username, :email

    def initialize(project_name)
      @project_name = project_name || ""
      @message_bank = MessageBank.new(self)
    end

    def run
      @message_bank.welcome_message

      projectname = @message_bank.get_project_name

      ProjectManipulator.new({
        :xcodeproj_path => "PROJECTNAME.xcodeproj",
        :projectname => projectname,
        :username => user_name,
        :date => date
      }).run

      @message_bank.pod_setup
      	
      clean_template_files
      reinitialize_git_repo
      run_pod_install

      @message_bank.farewell_message
    end

    #----------------------------------------#

    def run_pod_install
      puts "\nRunning " + "pod install".magenta + " on your new project."
      puts ""

      system "pod install"
    end

    def clean_template_files
      ["./**/.gitkeep", "configure", "_CONFIGURE.rb", "README.md", "setup", "generate.sh"].each do |asset|
        `rm -rf #{asset}`
      end
    end

    def reinitialize_git_repo
      `rm -rf .git`
      `git init`
      `git add -A`
      `git commit -m "Initial commit"`
    end

    def validate_user_details
        return (user_email.length > 0) && (user_name.length > 0)
    end

    #----------------------------------------#

    def project_name
      @project_name
    end

    def user_name
      (ENV['GIT_COMMITTER_NAME'] || `git config user.name`).strip
    end

    def user_email
      (ENV['GIT_COMMITTER_EMAIL'] || `git config user.email`).strip
    end

    def year
      Time.now.year.to_s
    end

    def date
      Time.now.strftime "%m/%d/%Y"
    end

    #----------------------------------------#
  end
end
