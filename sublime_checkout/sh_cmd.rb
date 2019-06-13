require 'English'

module SublimeCheckout
  module ShCmd
    def self.silent_cmd(command)
      cmd "#{command} 2>/dev/null"
    end

    def self.cmd(command)
      system(command)
    end

    def self.cmd_output(command)
      %x{#{command}}.chomp
    end
  end
end
