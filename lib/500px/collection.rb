module F00px
  class Collection < Base
    include Enumerable

    def initialize(response,*args)
      args = args.extract_options!
      @class = args[:class]
      @collection = args.delete(:collection)

      @request_path = args.delete(:request_path)
      @request_params = args.delete(:request_params)

      @client = args.delete(:client)
      @rpp = args.delete(:rpp) || 20

      if @collection.is_a?(Symbol) || @collection.is_a?(String)
        @items = response.delete(@collection.to_s)
      end

      @items.map! do |item|
        args[:class].new(item)
      end if args[:class]

      super(response)
    end

    def parse_response(response)
      if @collection.is_a?(Symbol) || @collection.is_a?(String)
        @items = response.delete(@collection.to_s)
      end

      @items.map! do |item|
        @class.new(item)
      end if @class

      @options = response
    end

    def each
      @items.each{|i| yield i}
    end

    def page!(n)
      response = @client.get(@request_path,@request_params.merge(
        :page => n))
      parse_response(response)
    end

    def next_page!
      if more_pages?
        page!(current_page + 1)
      else
        raise InvalidPageNumber.new(total_pages,current_page + 1)
      end
    end

    def previous_page!
      if current_page > 1
        page!(current_page - 1) 
      else
        raise InvalidPageNumber.new(total_pages,current_page - 1)
      end
    end

    def more_pages?
      current_page < total_pages
    end
  end
end
