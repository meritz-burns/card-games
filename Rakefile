require_relative 'config/application'
require 'graphql/rake_task'

Rails.application.load_tasks

task(:default).clear
task default: [:spec]

if defined? RSpec
  task(:spec).clear
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.verbose = false
  end
end

task default: "bundle:audit"

GraphQL::RakeTask.new(schema_name: "CntrlSchema")
