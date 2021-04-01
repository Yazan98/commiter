require "bundler/setup"
require "commiter/version"
require 'commiter_generator'

module Commiter

  class CommiterCli

    def self.print_help_messages(should_exit)
      puts "Command [-q] Generate Quick Git Messages Rules"
      puts "Command [-g] Generate Git Rules Based On Questions"
      puts "Command [-c] Generate Config File Without Change Git Rules"
      puts "Command [-d] Show Debug Messages While Generating Git Config"
      if should_exit
        exit
      end
    end

    def self.validate_command_args(option, should_show_debug_messages)
      case option
      when "-h"
        print_help_messages(true)
      when "-help"
        print_help_messages(true)
      when "--help"
        print_help_messages(true)
      when "-debug"
        @options[:verbose] = true
      when "-c"
        @options[:syntax_highlighting] = true
      when "-g"
        if should_show_debug_messages
          puts "Command [-g] Accepted Will Start Asking Questions Before Update Git Rules"
        end
      when "-q"
        if should_show_debug_messages
          puts "Command [-q] Accepted Generate Quick Git Messages Rules"
        end
      when "-c"
        if should_show_debug_messages
          puts "Command [-c] Accepted Generate Config File"
        end
      when "-d"
        if should_show_debug_messages
          puts "Command [-d] Accepted Will Show Debug Messages"
        end
      else
        puts "Command : [#{option} Rejected Use Cli -h To See The Supported Commands]"
      end

    end

    def self.start_cli
      cliParameters = ARGV
      should_show_debug_messages = false
      puts "########################### - Commiter Cli Starter -#################################"
      puts "Welcome To Commiter Version : #{Commiter::VERSION}"
      puts "This CLI Will Change Your Git Settings Commit Messages"
      puts "#####################################################################################"
      puts ""

      # Find Debug Option
      cliParameters.each do |item|
        if item == "-d"
          should_show_debug_messages = true
        end
      end

      if should_show_debug_messages
        puts "Commiter Arguments Validation Started ... With Input : #{cliParameters}"
      end

      # Start Validate CLI Params
      cliParameters.each do |item|
        self.validate_command_args(item, should_show_debug_messages)
      end

      puts ""
      # Start Generate If -g Found
      cliParameters.each do |item|
        if item == "-g"
          if should_show_debug_messages
            puts "Command [-g] Found Will Start The Generator ..."
          end
          CommiterGenerator::CommiterCliGenerator::start
        end

      end

    end

    start_cli
  end
end
