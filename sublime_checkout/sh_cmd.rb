require 'English'

module SublimeCheckout
  module ShCmd
    def self.cmd(command)
      `#{command}`
      return false if $CHILD_STATUS.nil?

      $CHILD_STATUS.to_i.zero? ? true : false
    end
  end
end
