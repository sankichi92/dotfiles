# frozen_string_literal: true

require 'rubocop/rake_task'

RuboCop::RakeTask.new

repo = Pathname(File.expand_path(__dir__))
home = Pathname(Dir.home)
config = Pathname(ENV.fetch('XDG_CONFIG_HOME', home.join('.config')))

desc 'Setup Git'
task default: %i[git]

desc 'Setup Git config and global ignore'
task git: [home.join('.gitconfig'), config.join('git/ignore')]

namespace :git do
  file home.join('.gitconfig') do |t|
    ln_s repo.join('config/git/config'), t.name
  end

  directory config.join('git')

  file config.join('git/ignore') => config.join('git') do |t|
    %w[macOS VisualStudioCode].each do |name|
      sh "curl -sS https://raw.githubusercontent.com/github/gitignore/main/Global/#{name}.gitignore >>#{t.name}"
    end
  end

  desc 'Remove Git config'
  task :clean do
    rm [home.join('.gitconfig'), config.join('git/ignore')]
  end
end
