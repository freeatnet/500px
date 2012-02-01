module F00px
  module Photos
    def photos(params={})
      response = get('photos',params)
      Collection.new(response,:photos) do |photo|
        F00px::Photo.new(photo)
      end
    end
  end
end
