APP_DIR = File.join(File.dirname(__FILE__), '..')
GEMSPEC = File.join(APP_DIR, 'app_config.gemspec')

desc 'Build the gem'
task :gem => ['gem:build']

namespace :gem do
  task :build do
    sh "gem build #{GEMSPEC}"
  end

  desc "Remove the gem"
  task :clean do
    sh "rm -f #{APP_DIR}/*.gem"
  end

  desc 'Clean, rebuild and install the gem'
  task :install do
    Rake::Task['gem:clean'].invoke
    Rake::Task['gem:build'].invoke
    gem = FileList["#{APP_DIR}/*.gem"].first
    raise 'Gem not found!' unless gem && File.exists?(gem)
    sh "gem uninstall app_config; gem install #{gem}"
  end
end