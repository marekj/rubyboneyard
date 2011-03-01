require 'pp'
require 'spec/autorun'

describe "diff require foo file from path3" do

  def r f
    pp f
    require f
    pp $x
  end

  before :each do
    $x = []
  end

  specify "this dir loads only once (no relative path generated)" do
    r File.dirname(__FILE__) + '/foo'
    r File.expand_path('../foo', __FILE__)
    # this illustrates that relative path here is ok when we require file in the same dir we are in
    $x.should == ['foo3']
  end

  specify "up dir loads twice (relative path used)" do
    #pp $LOAD_PATH
    #require 'watir'
    #pp $LOAD_PATH # now loadpath has rubygems libs that watir required
    r File.dirname(__FILE__) + '/../foo'
    r File.expand_path('../../foo', __FILE__)

    # to illustrate the require statement where the path is relative
    # it ends up loading the same file twice because the path to each file is uniq
    $x.should == ["foo2", "foo2"] #see redefined constant FOO warning
  end

  specify 'two files require the same file but at diff depths' do
    r File.expand_path('path4/path5/foo', File.dirname(__FILE__))
    r File.expand_path('path4/foo', File.dirname(__FILE__))

    # to illustrate the relative path in require
    # it reloads the same file twice since each time path is not uniq
    $x.should == ["foo5", "bar4", "foo4", "bar4"]
  end

#  specify "File.join dirname + file (loads twice, once with relative and once with expand_path)" do
#    r File.join(File.dirname(__FILE__), '..', 'foo') #relative
#    $x.should == ["foo2"] # loads it first time
#    r File.expand_path(File.join(File.dirname(__FILE__), '..', 'foo')) #full path will reload the foo again here
#    $x.should == ["foo2", "foo2"] # OH NO! it loaded it again.. TRAP
#  end

end