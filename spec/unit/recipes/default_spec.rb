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

    it "should add rbenv repo" do
      expect(chef_run).to add_apt_repository("rbenv")
    end

    it "update resources" do
      expect(chef_run).to update_apt_update("update")
    end

    it "should install rbenv" do
      expect(chef_run).to install_package("rbenv")
    end

    it "should install ruby" do
      expect(chef_run).to rbenv_system_install("ruby-2.4.0")
    end

    it "should install rails" do
      expect(chef_run).to install_gem_package("rails")
    end
  end
end
