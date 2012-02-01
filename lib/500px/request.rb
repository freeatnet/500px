require 'faraday'
require 'simple_oauth'
require '500px/response/json'

module F00px
  class Request < Faraday::Middleware
    def call(env)
      header = SimpleOAuth::Header.new(env[:method],env[:url],nil,@options)
      env[:request_headers]['Authorization'] = header.to_s
      @app.call(env)
    end

    def initialize(app,options)
      @app = app
      @options = options
    end
  end
end
