module F00px
  class Client
    def initialize(attrs={})
      Config.key = attrs[:key]
      Config.secret = attrs[:secret]
      Config.url = attrs[:url]
    end

    def credentials
      {
        :consumer_key => Config.key,
        :consumer_secret => Config.secret,
      }
    end

    def get(path, params={})
      response = connection.get do |req|
        req.url "/v1/#{path}"
        req.params = params
      end
      response.body
    end

    include F00px::Photos
    include F00px::Connection
  end
end
