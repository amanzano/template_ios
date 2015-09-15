# modified from CocoaPods lib template
# https://github.com/CocoaPods/pod-template

module Vivant
  class MessageBank
    attr_reader :configurator

    def initialize(config)
      @configurator = config
    end

    def show_prompt
      print " > ".green
    end

    def yellow_bang
      "! ".yellow
    end

    def green_bang
      "! ".green
    end

    def red_bang
      "! ".red
    end

    def run_command command, output_command=nil
      output_command ||= command

      puts "  " + output_command.magenta
      system command
    end

    def ask(question)
      answer = ""
      loop do
        puts "\n#{question}?"

        show_prompt
        answer = gets.chomp

        break if answer.length > 0

        print "\nYou need to provide an answer."
      end
      answer
    end

    def welcome_message
      unless @configurator.validate_user_details
        run_setup_questions
      end

      puts "\n------------------------------"
      puts ""
      puts "Setting up a new iOS project."
      puts "\n------------------------------"
    end

    def farewell_message
      puts "\n------------------------------"
      puts ""
      puts "New project has been set up."
      puts "Commit this project to your repository and"
      puts "setup your Jenkins build job."
      puts "\n------------------------------"
    end
    
    def pod_ask(question)
      answer = ""
      answerYes = false
      loop do
        puts "\n#{question}"

        show_prompt
        answer = gets.chomp
        valid = (answer == 'y') || (answer == 'Y') || (answer == 'n') || (answer == 'N')
        answerYes = (answer == 'y') || (answer == 'Y')

        break if valid == true

        print "\nYou need to provide an answer."
      end
      answerYes
    end

	def pod_setup
      puts "\n------------------------------"
      puts ""
      puts "Setting up a podfile"
      puts "\n------------------------------"
      
      podfile = File.open("Podfile", "w")
     
      podfile.write("source 'https://github.com/CocoaPods/Specs.git'\n")
      podfile.write("platform :ios, '7.0'\n")
      
      answer = pod_ask("Add AFNetworking?")
      if answer == true
 	    podfile.write("pod 'AFNetworking', '~> 2.5'\n")
      end
      
      answer = pod_ask("Add DateTools?")
      if answer == true
 	    podfile.write("pod 'NSDate+TimeAgo'\n")
      end
      
      answer = pod_ask("Add FacebookPop?")
      if answer == true
 	    podfile.write("pod 'pop', '~> 1.0'\n")
      end
      
      answer = pod_ask("Add SVProgressHUD?")
      if answer == true
 	    podfile.write("pod 'SVProgressHUD'\n")
      end
      
      answer = pod_ask("Add OHHTTPStubs?")
      if answer == true
 	    podfile.write("pod 'OHHTTPStubs'\n")
      end
      
      answer = pod_ask("Add InputValidators?")
      if answer == true
 	    podfile.write("pod 'InputValidators'\n")
      end
      
      puts "\nTest Target pods"
      puts "------------------------------"
      
      project_name = @configurator.project_name
      podfile.write("target :" + project_name + "Tests do\n")
      
      answer = pod_ask("Add KIF?")
      if answer == true
 	    podfile.write("  pod 'KIF'\n")
      end
      
      answer = pod_ask("pod 'OCMock'")
      if answer == true
 	    podfile.write("  pod 'OCMock'\n")
      end
      
      answer = pod_ask("Add Expecta?")
      if answer == true
 	    podfile.write("  pod 'Expecta'\n")
      end
      
      answer = pod_ask("Add Specta?")
      if answer == true
 	    podfile.write("  pod 'Specta'\n")
      end
      
      podfile.write("end")
    end

    def run_setup_questions

      puts yellow_bang + "Before you can create a new library we need to setup your git credentials."

      unless @configurator.user_name.length > 0
        puts "\n What is your name? "
        answer = ""

        loop do
          show_prompt

          answer = gets.downcase.chomp
          break if answer.length > 0

          puts red_bang + "Please enter a name."
        end

        puts ""
        puts green_bang + "Setting your name in git to " + answer
        run_command('git config --global user.name "' + answer + '"')
      end

      unless @configurator.user_email.length > 0
        puts "\n What is your email?"
        answer = ""

        loop do
          show_prompt
          answer = gets.downcase.chomp
          break if answer.length > 0

          puts red_bang + "Please enter a email."
        end

        puts ""
        puts green_bang + "Setting your email in git to " + answer
        run_command('git config --global user.email "' + answer + '"')
      end

    end

    def get_project_name
      project_name = @configurator.project_name || ""
      unless project_name.length > 0 
        loop do
          project_name = ask("What is the name of the project")

          if project_name.include?(' ')
            puts 'Your project name cannot contain spaces.'.red
          elsif project_name.length == 0
            puts 'Please enter a valid project name'.red
          else
            break
          end
        end
      end
      project_name
    end

  end
end
