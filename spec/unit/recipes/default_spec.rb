#
# Cookbook:: rails
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'rails::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    ['git-core', 'curl', 'zlib1g-dev', 'build-essential', 'libssl-dev', 'libreadline-dev', 'libyaml-dev,' 'libsqlite3-dev', 'sqlite3', 'libxml2-dev', 'libxslt1-dev', 'libcurl4-openssl-dev', 'software-properties-common', 'libffi-dev', 'nodejs', 'yarn'].each do |p|
      it "should install #{p}" do
        expect(chef_run).to install_package(p)
      end
    end

    it "should add dependency repo" do
      expect(chef_run).to add_apt_repository("dependencies")
    end

    it "should update resources" do
      expect(chef_run).to update_apt_update("update")
    end

    it "should sync the rbenv git repo" do
      expect(chef_run).to sync_git("rbenv")
    end

    it "should sync the ruby-build git repo" do
      expect(chef_run).to sync_git("ruby-build")
    end

    it "execute commands for rbenv and ruby-build" do
      expect(chef_run).to run_execute("add_rbenv_and_ruby-build")
    end

    it "execute commands for installing ruby" do
      expect(chef_run).to run_execute("install_and_globalise_ruby")
    end

    ['bundler', 'rails'].each do |g|
      it "should install #{g}" do
        expect(chef_run).to install_gem_package(g)
      end
    end

    it "execute command 'rbenv rehash'" do
      expect(chef_run).to run_execute("rbenv_rehash")
    end
  end
end
