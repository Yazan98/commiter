require "bundler/setup"
require "commiter/version"
require 'json'


module CommiterRules

  class CommiterRulesStarter

    # Start Position To Create The Ruby Executable File
    def self.start(save_path)

      begin
        File.open(save_path,"w") do |f|
          f.write("#!/usr/bin/ruby")
          f.write("exec < /dev/tty")
          f.write("./.git/hooks/commiter_validation.rb $1")
        end
      rescue => error
        puts "Error While Executing Git Rules : #{error.message}"
        puts error.backtrace
      end

    end

  end

end

