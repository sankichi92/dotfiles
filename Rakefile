# frozen_string_literal: true

desc 'Setup all'
task default: %i[git prezto vim aws rubocop ipython]

repo = Pathname(File.expand_path(__dir__))
home = Pathname(Dir.home)
config = Pathname(ENV.fetch('XDG_CONFIG_HOME', home.join('.config')))

git_config_src_to_dst = Dir[repo.join('config/git/*')].to_h { |f| [f, config.join("git/#{File.basename(f)}")] }

desc 'Setup Git config and global ignore'
task git: [*git_config_src_to_dst.values, config.join('git/ignore')]

namespace :git do
  directory config.join('git')

  git_config_src_to_dst.each do |src, dst|
    file dst => config.join('git') do
      ln_s src, dst
    end
  end

  file config.join('git/ignore') => config.join('git') do |t|
    %w[macOS VisualStudioCode].each do |name|
      sh "curl -sSf https://raw.githubusercontent.com/github/gitignore/main/Global/#{name}.gitignore >>#{t.name}"
    end
  end

  desc 'Remove Git config files'
  task :clean do
    rm_rf config.join('git')
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

desc 'Setup AWS CLI'
task aws: home.join('.aws/config')

namespace :aws do
  directory home.join('.aws')

  file home.join('.aws/config') => home.join('.aws') do |t|
    ln_s repo.join('config/aws/config'), t.name
  end

  desc 'Remove .aws/config'
  task :clean do
    rm_f home.join('.aws/config')
  end
end

desc 'Setup RuboCop'
task rubocop: config.join('rubocop/config.yml')

namespace :rubocop do
  directory config.join('rubocop')

  file config.join('rubocop/config.yml') => config.join('rubocop') do |t|
    ln_s repo.join('config/rubocop/config.yml'), t.name
  end

  desc 'Remove RuboCop configs'
  task :clean do
    rm_rf config.join('rubocop')
  end
end

desc 'Setup IPython'
task ipython: home.join('.ipython/profile_default/ipython_kernel_config.py')

namespace :ipython do
  directory home.join('.ipython/profile_default')

  file home.join('.ipython/profile_default/ipython_kernel_config.py') => home.join('.ipython/profile_default') do |t|
    ln_s repo.join('config/ipython/ipython_kernel_config.py'), t.name
  end

  desc 'Remove IPython config'
  task :clean do
    rm_rf home.join('.ipython/profile_default/ipython_kernel_config.py')
  end
end
