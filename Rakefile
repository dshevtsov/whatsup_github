# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:spec)

task default: :test

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = '--format pretty' # Any valid command line option can go here.
end

task test: %i[spec features]
