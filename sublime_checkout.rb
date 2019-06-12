#!/usr/share/rvm/rubies/ruby-2.6.3/bin/ruby

require 'byebug'

module SublimeCheckout
  autoload :GitCmd, './sublime_checkout/git_cmd'
  autoload :ShCmd, './sublime_checkout/sh_cmd'
  autoload :Projects, './sublime_checkout/projects'
  autoload :Project, './sublime_checkout/project'
  autoload :Workspace, './sublime_checkout/workspace'

  def self.sublime_checkout(branch)
    path = "#{ENV['HOME']}/.config/sublime-text-3".freeze
    unless File.exist?(File.join(path, Projects::USER_PATH))
      path = "#{ENV['HOME']}/Library/Application Support/Sublime Text 3".freeze
    end

    Projects.initialize(path)
    @project ||= Project.new(Dir.pwd)
    @project.checkout(branch)
    ShCmd.cmd("subl -a #{@project.workspace_path}")
  end
end

SublimeCheckout.sublime_checkout(ARGV.first)
