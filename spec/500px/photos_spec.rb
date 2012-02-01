require 'helper'

describe F00px::Photos do
  before :each do
    @client = F00px.new(:key => 'XMnartrdOwGkRChgzLHtvqzeh3FmvdIqlUOZE6CZ',
                        :secret => 'PLETDzuNrbjg5AgjtONWzj7fCBHfJRoC9ofwcknX')
  end
  
  describe '.photos' do
    it 'should return a collection of photos' do
      stub_get("/v1/photos").
        to_return(:body => fixture("photos_fresh.json"),
                  :headers => {:content_type => "application/json; charset=utf-8"})
      photos = @client.photos
      photos.should be_kind_of(F00px::Collection)
      photos.any?.should be_true
      photos.first.should be_kind_of(F00px::Photo)
    end
  end

  describe '.user_photos' do

  end
end
