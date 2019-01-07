require 'rake/testtask'
require_relative 'lib/wallpaper_email_presenter.rb'

Rake::TestTask.new do |t|
  t.libs << "tests"
  t.test_files = FileList['tests/test*.rb']
  t.verbose = true
end

desc "Run a test of the newsletter template"
task :template do
  FileUtils.mkdir_p('demo') unless Dir.exists?('demo')
  File.delete 'demo/index.html' if File.exists?('demo/index.html')
  File.write 'demo/index.html', WallpaperEmailPresenter.new().full_view
end
