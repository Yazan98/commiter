require "bundler/setup"
require_relative "commiter/version"
require 'json'


module CommiterRules

  class CommiterRulesStarter

    # Start Position To Create The Ruby Executable File
    def self.start(save_path)

      begin
        File.open(save_path,"w") do |f|
          f.write("#!/usr/bin/env ruby")
          f.write("")
          f.write("require 'json'")
          f.write("target_message_line = 0")
          f.write("target_text_message = \" \"")
          f.write("current_directory = __dir__")
          f.write("data_hash = \"\"")
          f.write("check_type = \"\"")
          f.write("")
          f.write("# --------------------- Step Read Commiter Configuration ----------------- #")
          f.write("text = File.open(ARGV[0]).read")
          f.write("     text.gsub!(/\r\n?/,\" \\n \")")
          f.write("     text.each_line do |line|")
          f.write("     target_text_message = line")
          f.write("end")
          f.write("")
          f.write("file = File.open current_directory + \"/commiterConfig.json\"")
          f.write("    data = JSON.load file")
          f.write("file.close")
          f.write("")
          f.write("json_from_file = File.read(current_directory + \"/commiterConfig.json\")")
          f.write("hash = JSON.parse(json_from_file)")
          f.write("check_type = hash[\"generated_style\"]")
          f.write("# --------------------- End Step Read Commiter Configuration ----------------- #")
          f.write("")
          f.write("")
          f.write("# --------------------- Step Check Commiter Configuration Enabled ----------------- #")
          f.write("if hash[\"is_enabled\"]")
          f.write("  # Hooks Enabled Start Validation")
          f.write("  # Will Continue To Check Based on Json Config")
          f.write("else")
          f.write("  # Hooks Disabled Continue")
          f.write("  exit 0")
          f.write("end")
          f.write("# --------------------- End Step Check Commiter Configuration Enabled ----------------- #")
          f.write("")
          f.write("# --------------------- Step Check if Ticket Number Exists ----------------- #")
          f.write("if check_type == \"t\"")
          f.write("   validation_message = hash[\"ticket_number_example\"]")
          f.write("   validation_message[\"{#}\"] = \"\"")
          f.write("   if target_text_message.include? validation_message")
          f.write("    puts \"Ticket Number Key Found, Good Commit Based on Configured Rules\"")
          f.write("    exit 0")
          f.write("  else")
          f.write("    puts \"Bad Commit Message (Ticket Number Not Found) Commit Rejected\"")
          f.write("    exit 1")
          f.write("  end")
          f.write("end")
          f.write("# --------------------- End Step Check if Ticket Number Exists ----------------- #")
          f.write("")
          f.write("# --------------------- Step Check if Commit Message Equals Black List Array ----------------- #")
          f.write("")
          f.write("if check_type == \"b\"")
          f.write("  black_list_words = hash[\"black_list_words\"]")
          f.write("  filtered_message = target_text_message.downcase.strip")
          f.write("  black_list_words.each { |value|")
          f.write("    if filtered_message == value.downcase.strip")
          f.write("      puts \"Bad Commit Message (\" " + value + " Message Not Acceptable) Commit Rejected\"")
          f.write("      exit 1")
          f.write("    end")
          f.write("  }")
          f.write("end")
          f.write("# --------------------- End Step Check if Commit Message Equals Black List Array ----------------- #")
          f.write("")
          f.write("# --------------------- Step Check Commit Message Equals Regex ----------------- #")
          f.write("if check_type == \"r\"")
          f.write("  if target_text_message.match(hash[\"regex_input\"])")
          f.write("    # Input Regex Matched")
          f.write("    exit 0")
          f.write("  else")
          f.write("    puts \"Bad Commit Message (Message Not Match Regex) Commit Rejected\"")
          f.write("    exit 1")
          f.write("  end")
          f.write("end")
          f.write("# --------------------- End Step Check Commit Message Equals Regex ----------------- #")
          f.write("")
          f.write("")
        end
      rescue => error
        puts "Error While Executing Git Rules : #{error.message}"
        puts error.backtrace
      end

    end

  end

end

