module F00px
  class Base
    @options = {}

    def initialize(options={})
      @options = options
    end

    def [](name)
      @options[name]
    end

    def method_missing(name)
      @options[name.to_s]
    end
  end
end
