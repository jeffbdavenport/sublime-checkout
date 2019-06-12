module SublimeCheckout
  class Project
    attr_reader :name, :path, :workspace

    def initialize(path)
      @name = File.basename(path)
      @path = path
      create_project unless exists?
      @workspace = Workspace.new(self, branch)
    end

    def exists?
      File.exist?(file_path) && File.exist?(workspace_file_path)
    end

    def file
      "#{@name}.sublime-project"
    end

    def workspace_path
      workspace.exists? ? workspace.file_path : file_path
    end

    def workspace_file
      "#{@name}.sublime-workspace"
    end

    def workspace_file_path
      File.join(Projects.path, workspace_file)
    end

    def file_path
      File.join(Projects.path, file)
    end

    def branch
      GitCmd.current_branch
    end

    def checkout(branch)
      @workspace = Workspace.new(self, branch)
    end

    private

      def create_project
        create_project_file
        # create_workspace_file
      end

      def create_project_file
        File.open(file_path, 'w') do |file|
          file.write <<~FILE
            {
              "folders":
              [{
                "path": "#{path}"
              }]
            }
          FILE
        end
      end

      def create_workspace_file
        File.open(workspace_file_path, 'w') do |file|
          file.write <<~FILE
            {
              "project": "#{file_path}"
            }
          FILE
        end
      end
  end
end
