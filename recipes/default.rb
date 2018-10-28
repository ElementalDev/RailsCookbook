#
# Cookbook:: rails
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Include the nodejs recipe
include_recipe("nodejs")

['git-core', 'curl', 'zlib1g-dev', 'build-essential', 'libssl-dev', 'libreadline-dev', 'libyaml-dev,' 'libsqlite3-dev', 'sqlite3', 'libxml2-dev', 'libxslt1-dev', 'libcurl4-openssl-dev', 'software-properties-common', 'libffi-dev', 'yarn'].each do |p|
  package(p) do
    action :install
  end
end
