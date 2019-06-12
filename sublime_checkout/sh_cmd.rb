require 'English'

module SublimeCheckout
  module ShCmd
    def self.silent_cmd(command)
      cmd "#{command} 2>/dev/null"
    end

    def self.cmd(command)
      @output = `#{command}`
      return false if $CHILD_STATUS.nil?

      $CHILD_STATUS.to_i.zero? ? true : false
    end

    def self.cmd_output(command)
      `#{command}`.chomp
    end
  end
end
