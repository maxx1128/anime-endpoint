require_relative 'lib/wallpaper_email_presenter.rb'

desc "Run a test of the newsletter template"
task :template do
  FileUtils.mkdir_p('demo') unless Dir.exists?('demo')
  File.delete 'demo/index.html' if File.exists?('demo/index.html')
  File.write 'demo/index.html', WallpaperEmailPresenter.new().full_view
end
