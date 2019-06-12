require 'fileutils'

module SublimeCheckout
  class Workspace
    attr_reader :project, :branch

    def initialize(project, branch)
      @project = project
      @branch = branch
      checkout(branch)
      create_workspace
    end

    def checkout(branch)
      GitCmd.checkout(branch) || GitCmd.checkout_new(branch)
    end

    def file
      "#{@branch}.sublime-workspace"
    end

    def project_file_path
      File.join(Projects.path, project.name, project.file)
    end

    def file_path
      File.join(Projects.path, project.name, file)
    end

    def file_directory
      File.join(Projects.path, project.name)
    end

    def exists?
      File.exist?(file_path)
    end

    private

    def create_workspace
      FileUtils.mkdir_p(file_directory)
      FileUtils.symlink(project.file_path, project_file_path) unless File.exist?(project_file_path)
      return unless File.exist?(project.workspace_file_path)
      FileUtils.cp(project.workspace_file_path, file_path)
    end
  end
end
