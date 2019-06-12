require 'fileutils'

module SublimeCheckout
  module Projects
    USER_PATH = 'Packages/User'.freeze
    PROJECTS_PATH = File.join(USER_PATH, 'Projects').freeze

    def self.initialize(path)
      @path = File.join(path, PROJECTS_PATH)
      FileUtils.mkdir_p(@path) unless File.exist?(@path)
    end

    def self.path
      @path
    end
  end
end
