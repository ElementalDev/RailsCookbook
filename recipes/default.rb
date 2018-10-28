#
# Cookbook:: rails
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Include the nodejs recipe
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
