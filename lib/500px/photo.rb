module F00px
  class Photo < Base

    def initialize(options)
      user = options.delete('user')
      super(options)
      @options['user'] = F00px::User.new(user)
    end
  end
end
