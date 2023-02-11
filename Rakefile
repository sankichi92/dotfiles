# frozen_string_literal: true

require 'rubocop/rake_task'

RuboCop::RakeTask.new

desc 'Setup Git, Prezto, and Vim'
task default: %i[git prezto vim]

repo = Pathname(File.expand_path(__dir__))
home = Pathname(Dir.home)
config = Pathname(ENV.fetch('XDG_CONFIG_HOME', home.join('.config')))

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

  desc 'Remove Git config files'
  task :clean do
    rm_f [home.join('.gitconfig'), config.join('git/ignore')]
  end
end

zdotdir = Pathname(ENV.fetch('ZDOTDIR', Dir.home))
zdotfiles = %w[zlogin zlogout zprofile zshenv zshrc].map { |f| zdotdir.join(".#{f}") }

desc 'Setup Prezto'
task prezto: zdotfiles

namespace :prezto do
  file zdotdir.join('.zprezto') do |t|
    sh "git clone -q --recursive https://github.com/sankichi92/prezto.git #{t.name}"
  end

  zdotfiles.each do |zdotfile|
    file zdotfile => zdotdir.join('.zprezto') do
      ln_s zdotdir.join('.zprezto/runcoms', zdotfile.basename.to_s[1..]), zdotfile
    end
  end

  desc 'Remove .zprezto'
  task :clean do
    rm_f zdotfiles
    rm_rf zdotdir.join('.zprezto')
  end
end

desc 'Setup .vimrc'
task vim: home.join('.vimrc')

namespace :vim do
  file home.join('.vimrc') do |t|
    ln_s repo.join('config/vim/vimrc'), t.name
  end

  desc 'Remove .vimrc'
  task :clean do
    rm_f home.join('.vimrc')
  end
end
