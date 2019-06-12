#!/usr/bin/ruby

require 'sublime_checkout/*'

module SublimeCheckout
  PROJECTS_HOME = "#{ENV['HOME']}/.config/sublime-text-3/Packages/User/Projects"
  @project ||= File.basename(Dir.pwd)
end
