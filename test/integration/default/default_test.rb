# # encoding: utf-8

# Inspec test for recipe rails::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# This is an example test, replace it with your own test.
['git-core', 'curl', 'zlib1g-dev', 'build-essential', 'libssl-dev', 'libreadline-dev', 'libyaml-dev,' 'libsqlite3-dev', 'sqlite3', 'libxml2-dev', 'libxslt1-dev', 'libcurl4-openssl-dev', 'software-properties-common', 'libffi-dev', 'nodejs', 'yarn'].each do |p|
  describe package(p) do
    it {should be_installed}
  end
end

describe package("rbenv") do
  it {should be_installed}
  its("version") {should match /2\./}
end

describe package("ruby") do
  it {should be_installed}
  its("version") {should match /2\.4\.5/}
end

describe gem("rails") do
  it {should be_installed}
  its("version") {should match /2\.5\.1/}
end
