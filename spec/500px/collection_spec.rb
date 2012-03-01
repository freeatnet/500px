require 'helper'

describe F00px::Collection do
  before :each do
     @client = F00px.new(:key => 'XMnartrdOwGkRChgzLHtvqzeh3FmvdIqlUOZE6CZ',
                          :secret => 'PLETDzuNrbjg5AgjtONWzj7fCBHfJRoC9ofwcknX',
                          :url => 'http://api.500px.com:3000')
  end

  describe '#new' do
    it 'should map collection items onto class' do
      F00px::Photo.should_receive(:new).exactly(3).times
      collection = F00px::Collection.new(
        { 'items' => [1,2,3] },
        :collection => :items,
        :class => F00px::Photo)
    end
  end

  context 'pagination' do
    before :each do
      @response = {
          'items' => [{:a => 'a'}],
          'current_page' => 1,
          'total_pages' => 2,
          'rpp' => 20,
          'total_items' => 40}.freeze
      @page_2_response = @response.merge(
        'current_page' => 2,
        'items' => [{:b => 'b'}]).freeze
      @collection = F00px::Collection.new(
        @response.dup,
        :client => @client,
        :collection => 'items',
        :class => F00px::Base,
        :request_path => 'items',
        :request_params => { :test => 'testing' })
    end
  
    describe '.page!' do
      it 'should get specific page' do
        stub_get("/v1/items?test=testing&page=2").
          to_return(:body => @page_2_response.to_json)
        @collection.page!(2)
        @collection.current_page.should == 2
      end
    end

    describe '.next_page!' do
      it 'should go to next page' do
        stub_get("/v1/items?test=testing&page=2").
          to_return(:body => @page_2_response.to_json)
        @collection.next_page!
        @collection.current_page.should == 2
      end

      it 'should raise an error if you try to go past the last page' do
        stub_get("/v1/items?test=testing&page=2").
          to_return(:body => @page_2_response.to_json)
        @collection.next_page!
        @collection.current_page.should == 2

        lambda { @collection.next_page! }.should raise_error(F00px::InvalidPageNumber)
      end
    end

    describe '.previous_page!' do
      it 'should go to the previous page' do
        stub_get("/v1/items?test=testing&page=2").
          to_return(:body => @page_2_response.to_json)
        @collection.next_page!
        @collection.current_page.should == 2

        stub_get("/v1/items?test=testing&page=1").
          to_return(:body => @response.to_json)
        @collection.previous_page!
        @collection.current_page.should == 1
      end

      it 'should raise an error if you try to get before the first page' do
        lambda { @collection.previous_page! }.should raise_error(F00px::InvalidPageNumber)
      end
    end

    describe '.more_pages?' do
      it 'should return true if there are more pages' do
        @collection.more_pages?.should eq(true)
      end

      it 'should return false if there arent more pages' do
        stub_get("/v1/items?test=testing&page=2").
          to_return(:body => @page_2_response.to_json)
        @collection.page!(2)
        @collection.more_pages?.should eq(false)
      end
    end
  end
end
