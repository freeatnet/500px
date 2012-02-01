require 'helper'

describe F00px::Photos do
  before :each do
    @client = F00px.new(:key => 'XMnartrdOwGkRChgzLHtvqzeh3FmvdIqlUOZE6CZ',
                        :secret => 'PLETDzuNrbjg5AgjtONWzj7fCBHfJRoC9ofwcknX')
  end
  
  describe 'photos' do
    it 'should return a list of photos' do
      photos = @client.photos(:feature => 'user', :username => 'tye')
      for photo in photos
        puts "#{photo.name} by #{photo.user.firstname} #{photo.user.lastname}"
      end
    end
  end
end
