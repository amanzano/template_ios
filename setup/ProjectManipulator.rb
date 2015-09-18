# modified from CocoaPods lib template
# https://github.com/CocoaPods/pod-template

require 'xcodeproj'

module Vivant

  class ProjectManipulator
    attr_reader :xcodeproj_path, :projectname, :username, :date, :string_replacements

    def self.perform(options)
      new(options).perform
    end

    def initialize(options)
      @xcodeproj_path = options.fetch(:xcodeproj_path)
      @projectname = options.fetch(:projectname)
      @username = options.fetch(:username)
      @today = options.fetch(:date)
    end

    def run
      @string_replacements = {
        "PROJECTNAME" => @projectname,
        "TODAY" => @today
      }
      replace_internal_project_settings

      rename_files
      rename_project_folder
    end

    def project_folder
      File.dirname @xcodeproj_path
    end

    def rename_files

      # shared schemes have project specific names
      scheme_path = project_folder + "/PROJECTNAME.xcodeproj/xcshareddata/xcschemes/"
      File.rename(scheme_path + "PROJECTNAME.xcscheme", scheme_path +  @projectname + ".xcscheme")

      # rename xcproject
      File.rename(project_folder + "/PROJECTNAME.xcodeproj", project_folder + "/" +  @projectname + ".xcodeproj")

      # rename tests
      File.rename(project_folder + "/PROJECTNAMETests/PROJECTNAMETests.m", project_folder + "/PROJECTNAMETests/" + @projectname + "Tests.m")
      
    end

    def rename_project_folder
      if Dir.exist? project_folder + "/PROJECTNAME"
        File.rename(project_folder + "/PROJECTNAME", project_folder + "/" + @projectname)
      end

      if Dir.exist? project_folder + "/PROJECTNAMETests"
        File.rename(project_folder + "/PROJECTNAMETests", project_folder + "/" + @projectname + "Tests")
      end
    end

    def replace_internal_project_settings
      invalid_formats = [".png", ".jpg", ".rb", ".mobileprovision"]

      Dir.glob(project_folder + "/**/**/**/**").each do |name|
        next if Dir.exists? name
        if(!invalid_formats.include? File.extname(name))
          text = File.read(name)
          for find, replace in @string_replacements
              text = text.gsub(find, replace)
          end
          File.open(name, "w") { |file| file.puts text }
        end
      end
    end

    def date
      Time.now.strftime "%m/%d/%Y"
    end

  end

end
