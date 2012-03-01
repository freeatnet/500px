module F00px
  module Photos
    def photos(params={})
      response = get('photos',params)

      Collection.new(response,
                     :collection => :photos,
                     :request_path => 'photos',
                     :request_params => params,
                     :client => self,
                     :class => F00px::Photo)
    end

    def user_photos(user,*args)
      if user.kind_of?(User)
        options = { :feature => 'user',
                    :username => user.username }
      elsif user =~ /^\d+$/
        options = { :features => 'user',
                    :user_id => user }
      else
        options = { :feature => 'user',
                    :username => user }
      end

      photos(args.extract_options!.merge(options))
    end

    def popular_photos(*args)
      photos args.extract_options!.merge(
        :feature => 'popular')
    end
  end
end
