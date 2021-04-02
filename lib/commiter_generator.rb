require "bundler/setup"
require_relative "commiter/version"
require 'json'
require_relative '../lib/commiter_rules_generator'

module CommiterGenerator

  class CommiterCliGenerator

    def self.validate_command_options(value)
      case value
      when "t"
        puts "Option Selected : Ticket Number Validation ..."
      when "b"
        puts "Option Selected : BlackList Validation Validation ..."
      when "r"
        puts "Option Selected : Regex Validation ..."
      else
        puts "Unknown Option : #{value} Stop Process ..."
        exit
      end
    end

    # Generate Shell File To Execute Commit Message Validation
    def self.generate_sh_file(save_path)
      begin
        # Start Generating Git Rules File
        CommiterRules::CommiterRulesStarter::start(save_path)
      rescue => error
        puts "Something Error : #{error.message}"
        puts error.backtrace
      end
    end

    def self.generate_json_file(
      save_path,
      black_list_words,
      regex_input,
      ticket_number_example,
      is_enabled,
      generated_style,
      max_length,
      is_global_configuration_enabled
    )
      is_commits_enabled = false
      if is_enabled == "y"
        is_commits_enabled = true
      end

      tempHash = {
        "black_list_words" => black_list_words.to_s.split(","),
        "regex_input" => regex_input,
        "ticket_number_example" => ticket_number_example,
        "is_enabled" => is_commits_enabled,
        "generated_style" => generated_style,
        "max_length" => max_length,
        "is_global_configuration_enabled" => is_global_configuration_enabled
      }

      # Save File For History
      begin
        File.open("commiterConfig.json","w") do |f|
          f.write(JSON.pretty_generate(tempHash))
        end
      rescue => error
        puts "Something Error : #{error.message}"
        puts error.backtrace
      end

      begin
        File.open(save_path,"w") do |f|
          f.write(JSON.pretty_generate(tempHash))
        end
      rescue => error
        puts "Something Error : #{error.message}"
        puts error.backtrace
      end

      puts ""
      puts "Commiter Wrote Json Config File [commiterConfig.json] To Your Project :D"
      puts "Any One Pull The Project He Can Start Commiter With [-q] Parameter and Will Generate Git Rules Based On This File"
      puts "Any Update on The File You Should Execute Commiter -q Again To Apply The Changes"
      puts "Now Enjoy With Your Commit Messages :D"
      exit
    end

    def self.start
      puts ""
      puts "Commiter Generator Started To Ask Questions Before Generate Config File"
      black_list_words = []
      regex_input = ""
      ticket_number_example = ""

      save_path = ".git/hooks/commiterConfig.json"
      shell_script_save_path = ".git/hooks/commit-msg"

      # 1. First Question Choose Your Commits Type
      puts "Please Choose Your Type of Commit Checking From This Types"
      puts " Option : Write [t] To Check If Commit Has Ticket Number First or Not In Commit Messages"
      puts " Option : Write [b] To Check If Commit Has Word From Black List Words That Blocked From Messages Like Dummy Messages"
      puts " Option : Write [r] To Check Commit Messages Based on Regex String"
      print "Your Answer ? "
      generated_style = STDIN.gets.chomp
      validate_command_options(generated_style)

      # 2. If Option is BlackList Ask to Enter BlackList
      puts ""
      if generated_style == "b"
        puts "Based On Your Option You Selected To Block Some Words From Commit Messages Can You Enter Them Like This (Fix,Version,Change) ?"
        black_list_words = STDIN.gets.chomp
        puts "Your Options Saved Will Add Them To Config File And You Can Change Them Anytime From Config File"
        puts "Saved Options : #{black_list_words}"
      end

      # 3. If Option is Regex Ask to Enter This Regex
      if generated_style == "r"
        puts "Based On Your Option You Selected To Validate Commit Message Based on Regex Enter This Regex Please"
        print "Your Answer ? "
        regex_input = STDIN.gets.chomp
        puts "Your Options Saved Will Add Them To Config File And You Can Change Them Anytime From Config File"
        puts "Saved Option : #{regex_input}"
      end

      # 4. Check if Option is Ticket Number
      if generated_style == "t"
        puts "Based On Your Option You Selected To Validate Commit Message Based on Ticket Number Enter The Key And The Dynamic Number Like [Ticket-{#}] (The {#} Is The Dynamic Number)"
        print "Your Answer ? "
        ticket_number_example = STDIN.gets.chomp
        puts "Your Options Saved Will Add Them To Config File And You Can Change Them Anytime From Config File"
        puts "Saved Option : #{ticket_number_example}"
      end

      # 5. Should Enable The Validation Once Commiter Finish The Settings ?
      puts "Should Enable The Validation Once Commiter Finish The Settings The Available Options [y,n] Default Value [y] ?"
      print "Your Answer ? "
      is_enabled = STDIN.gets.chomp
      puts "Your Options Saved Will Add Them To Config File And You Can Change Them Anytime From Config File"
      puts "Saved Option : #{is_enabled}"

      # 6. Max Length of Message Line
      puts "What is the Maximum Length of Commit Message Default [50]"
      print "Your Answer ? "
      max_length = STDIN.gets.chomp
      puts "Your Options Saved Will Add Them To Config File And You Can Change Them Anytime From Config File"
      puts "Saved Option : #{max_length}"

      # 7. Save Template In Git
      puts "Do You want To Copy This Files to Git Template Root as a Global Configuration [y,n] Default is [y]"
      print "Your Answer ? "
      is_global_configuration_enabled = STDIN.gets.chomp
      puts "Your Options Saved Will Add Them To Config File And You Can Change Them Anytime From Config File"
      puts "Saved Option : #{is_global_configuration_enabled}"

      begin
        max_length = max_length.to_i
      rescue => error
        puts "Something Error : #{error}"
      end

      # 6. Save Items In Config Json File
      generate_json_file(save_path, black_list_words, regex_input, ticket_number_example, is_enabled, generated_style, max_length, is_global_configuration_enabled)
      generate_sh_file(shell_script_save_path)

      if is_global_configuration_enabled == "y"
        sh("cd ..")

        begin
          sh("mkdir ~/.git_template")
        rescue => error
          puts "Something Wrong With Error : #{error.message}"
        end

        sh("git config --global init.templatedir '~/.git_template'")
        # Copy Generated Files to Your Root Template Location
      end

    end

  end

end
