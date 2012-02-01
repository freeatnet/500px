require '500px'
require 'rspec'
require 'webmock/rspec'

def stub_get(path, endpoint='http://api.500px.com:3000')
  stub_request(:get, endpoint + path)
end
def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

