require 'English'

module SublimeCheckout
  module GitCmd
    def self.silent_checkout(branch)
      ShCmd.silent_cmd("git checkout #{branch}")
    end

    def self.checkout(branch)
      cmd("checkout #{branch}")
    end

    def self.checkout_new(branch)
      cmd("checkout -b #{branch}")
    end

    def self.cmd(command)
      ShCmd.cmd("git #{command}")
    end

    def self.cmd_output(command)
      ShCmd.cmd_output("git #{command}")
    end

    def self.current_branch
      cmd_output('rev-parse --abbrev-ref HEAD')
    end
  end
end
