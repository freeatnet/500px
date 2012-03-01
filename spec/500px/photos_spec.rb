require 'helper'

describe F00px::Photos do
  before :each do
    @client = F00px.new(:key => 'XMnartrdOwGkRChgzLHtvqzeh3FmvdIqlUOZE6CZ',
                        :secret => 'PLETDzuNrbjg5AgjtONWzj7fCBHfJRoC9ofwcknX',
                        :url => 'http://api.500px.com:3000')
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
    it 'should return a collection of photos' do
      stub_get("/v1/photos?feature=user&username=tchebotarev").
        to_return(:body => fixture("user_photos.json"))

      photos = @client.user_photos('tchebotarev')

      photos.should be_kind_of F00px::Collection
      photos.any?.should be_true
      photos.first.should be_kind_of F00px::Photo
    end
  end

  describe '.popular' do
    it 'should return a collection of photos' do
      stub_get("/v1/photos?feature=popular").
        to_return(:body => fixture("popular_photos.json"))

      photos = @client.popular_photos

      photos.should be_kind_of F00px::Collection
      photos.any?.should be_true
      photos.first.should be_kind_of F00px::Photo
    end

    it 'should pass extra arguments as parameters' do
      stub_get("/v1/photos?feature=popular&page=2").
        to_return(:body => fixture('popular_photos.json'))

      photos = @client.popular_photos(:page => 2)
    end
  end
end

# popular — Return photos in Popular
# upcoming — Return photos in Upcoming
# editors — Return photos in Editors' Choice
# fresh_today — Return photos in Fresh Today
# fresh_yesterday — Return photos in Fresh Yesterday
# fresh_week — Return photos in Fresh This Week
