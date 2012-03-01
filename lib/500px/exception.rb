module F00px
  class Exception < ::Exception
    def initialize(*args)
      super(*args)
    end
  end

  class InvalidPageNumber < Exception
    def initialize(total_pages,current_page)
      super("Invalid page number: #{current_page} (Min: 1 Max: #{total_pages}")
    end
  end
end
