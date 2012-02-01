module F00px::Config
  URL = 'http://api.500px.com:3000'
  
  @config = {}
  def self.method_missing(name,*args)
    if name[-1] == '='
      @config[name[0..-2].to_sym] = args.first
    else
      @config[name.to_sym]
    end
  end
end
