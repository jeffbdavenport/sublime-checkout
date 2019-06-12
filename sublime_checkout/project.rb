module SublimeCheckout
  class Project
    attr_accessor :branch

    def initialize(project, path, branch)
      @project = project
      @path = path
      @branch = branch
    end

    def checkout(branch)
      GitCmd.checkout(branch) || GitCmd.checkout_new(branch)
    end
  end
end
