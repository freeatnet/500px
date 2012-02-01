require 'helper'

describe F00px::Client do
  describe '.new' do
    it 'should record key & secret' do
      F00px.new(
        :key => 'test',
        :secret => 'test')
      F00px::Config.key.should == 'test'
    end
  end
end
