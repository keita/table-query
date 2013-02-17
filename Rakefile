require "bundler/gem_tasks"

desc 'Generate API document'
task 'html' do
  sh "yard doc -o html --hide-void-return --no-api"
end

desc 'Show undocumented function list'
task 'html:undoc' do
  sh "yard stats --list-undoc --no-api"
end
