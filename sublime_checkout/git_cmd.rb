require 'English'

module SublimeCheckout
  module GitCmd
    def self.checkout(branch)
      cmd("checkout #{branch}")
    end

    def self.checkout_new(branch)
      cmd("checkout -b #{branch}")
    end

    def self.cmd(command)
      ShCmd.cmd("git #{command}")
    end
  end
end
