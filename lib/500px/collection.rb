module F00px
  class Collection < Base
    include Enumerable

    def initialize(options,items,&block)
      if items.is_a?(Symbol) || items.is_a?(String)
        @items = options.delete(items.to_s)
      else
        @items = items
      end

      if block && @items
        @items.map!(&block)
      end

      super(options)
    end

    def each
      @items.each{|i| yield i}
    end

  end
end
