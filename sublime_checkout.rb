require 'fileutils'
require_relative 'sublime_checkout/git_cmd'
require_relative 'sublime_checkout/sh_cmd'
require_relative 'sublime_checkout/projects'
require_relative 'sublime_checkout/project'
require_relative 'sublime_checkout/workspace'

module SublimeCheckout
  def self.sublime_checkout(branch)
    path = "#{ENV['HOME']}/.config/sublime-text-3".freeze
    unless File.exist?(File.join(path, Projects::USER_PATH))
      path = "#{ENV['HOME']}/Library/Application Support/Sublime Text 3".freeze
    end

    Projects.initialize(path)
    @project ||= Project.new(Dir.pwd)
    @project.checkout(branch)
    # We need to run the command twice to save the new workspace
    ShCmd.cmd("subl --project #{@project.workspace_path} -a")
    sleep 0.1
    ShCmd.cmd("subl --project #{@project.workspace_path} -a")
  end
end

SublimeCheckout.sublime_checkout(*ARGV)
