require 'helper'

describe F00px::Photos do
  before :each do
    @client = F00px.new(:key => 'XMnartrdOwGkRChgzLHtvqzeh3FmvdIqlUOZE6CZ',
                        :secret => 'PLETDzuNrbjg5AgjtONWzj7fCBHfJRoC9ofwcknX')
  end
  
  describe 'photos' do
    it 'should return a list of photos' do
      raise @client.photos.inspect
    end
  end
end
