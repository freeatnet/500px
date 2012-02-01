module F00px
  class << self
    def new(options={})
      F00px::Client.new(options)
    end
  end
end

require 'json'

require '500px/config'
require '500px/request'
require '500px/connection'
require '500px/photos'

require '500px/base'
require '500px/collection'
require '500px/photo'
require '500px/user'

require '500px/client'
