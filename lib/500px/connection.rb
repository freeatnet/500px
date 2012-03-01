module F00px
  module Connection
    def connection
      options = {
        :headers => {
          :accept => 'application/json',
          :user_agent => '500px gem'
        },
        :url => Config.url
      }
      Faraday.new(options) do |builder|
        builder.use F00px::Request, credentials
        builder.use F00px::Response::Json
        builder.adapter :net_http
      end
    rescue Exception => e
      puts "#{e.class.name}: #{e.message}"
    end
  end
end
