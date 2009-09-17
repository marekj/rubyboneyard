require 'rake'
#
#task :set_ci_reporter do
#  gem 'ci_reporter'
#  require 'ci/reporter/rake/rspec'
#end
#
#require 'spec/rake/spectask'
#Spec::Rake::SpecTask.new(:spec => ["set_ci_reporter", "ci:setup:rspec"]) do |t|
#  t.fail_on_error = true
#  t.spec_files = FileList["spec/array_test.rb"]
#end

require 'rake/testtask'
Rake::TestTask.new(:testu) do |t|
  t.test_files = FileList["test/*.rb"]
end
