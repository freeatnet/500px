module F00px
  module Photos
    def photos(params={})
      response = get('photos',params)

      Collection.new(response,:photos) do |photo|
        F00px::Photo.new(photo)
      end
    end

    def user_photos(user)
      if user.kind_of?(User)
        response = get('photos',
                       :feature => 'user',
                       :username => user.username)
      elsif user =~ /^\d+$/
        response = get('photos',
                       :features => 'user',
                       :user_id => user)
      else
        response = get('photos',
                       :feature => 'user',
                       :username => user)
      end

      Collection.new(response,:photos) do |photo|
        F00px::Photo.new(photo)
      end
    end
  end
end
