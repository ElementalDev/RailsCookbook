#
# Cookbook:: rails
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Include the nodejs recipe

$rbenv_inst = <<-HEREDOC

echo 'export PATH="$HOME/.rbenv/bin:/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

HEREDOC


$ruby_inst = <<-HEREDOC

rbenv install 2.4.5
rbenv global 2.4.5

HEREDOC


include_recipe("nodejs")

# Add the dependency repository for install
apt_repository("dependencies") do
  key "https://dl.yarnpkg.com/debian/pubkey.gpg"
  uri "https://dl.yarnpkg.com/debian/"
  distribution "stable"
  components ["main"]
  action :add
end

# Update the resources
apt_update("update") do
  action :update
end

# Install dependencies
['git-core', 'curl', 'zlib1g-dev', 'build-essential', 'libssl-dev', 'libreadline-dev', 'libyaml-dev,' 'libsqlite3-dev', 'sqlite3', 'libxml2-dev', 'libxslt1-dev', 'libcurl4-openssl-dev', 'software-properties-common', 'libffi-dev', 'yarn'].each do |p|
  package(p) do
    action :install
  end
end

git("rbenv") do
  repository "https://github.com/rbenv/rbenv.git"
  destination "~/.rbenv"
  action :sync
end

git("ruby-build") do
  repository "https://github.com/rbenv/ruby-build.git"
  destination "~/.rbenv"
  action :sync
end

execute("add_rbenv_and_ruby-build") do
  command $rbenv_inst
  action :run
end

execute("install_and_globalise_ruby") do
  command $ruby_inst
  action :run
end

['bundler', 'rails'].each do |g|
  gem_package(g) do
    action :install
  end
end

execute("rbenv_rehash") do
  command "rbenv rehash"
  action :run
end
