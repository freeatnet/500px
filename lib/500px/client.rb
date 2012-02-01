module F00px
  class Client
    def initialize(attrs={})
      Config.key = attrs[:key]
      Config.secret = attrs[:secret]
    end

    def credentials
      {
        :consumer_key => Config.key,
        :consumer_secret => Config.secret,
      }
    end

    def get(path, params={})
      response = connection.get("/v1/#{path}")
      response.body
    end

    include F00px::Photos
    include F00px::Connection
  end
end
