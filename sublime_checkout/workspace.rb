require 'fileutils'

module SublimeCheckout
  class Workspace
    attr_reader :project

    def initialize(project, branch)
      @project = project
      @branch = branch
      create_workspace
    end

    def checkout(to_branch)
      @branch = to_branch
      create_workspace
      GitCmd.checkout(branch) || GitCmd.checkout_new(branch)
    end

    def branch
      (@branch.nil? || @branch == '') ? project.branch : @branch
    end

    def file
      "#{branch}.sublime-workspace"
    end

    def project_file_path
      File.join(Projects.path, project.name, project.file)
    end

    def branch_project_path
      File.join(Projects.path, project.name, "#{branch}.sublime-project")
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
        FileUtils.symlink(project.file_path, branch_project_path) unless File.exist?(branch_project_path)
        FileUtils.symlink(project.file_path, project_file_path) unless File.exist?(project_file_path)
        return unless File.exist?(project.workspace_file_path)

        FileUtils.cp(project.workspace_file_path, file_path)
      end
  end
end
