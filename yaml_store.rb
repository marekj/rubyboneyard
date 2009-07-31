require 'yaml/store'

class YAML::Store

  # inserts hash with more than one key
  #
  #  ys.transaction do
  #    ys.update :bla => 'value', :foot => 'foo value', :baz => 'baz value'
  #  end
  #
  def update(hash)
    #this is on a safe side using PStore[name] method
    #hash.each {|name, value| self[name] = value} 
    in_transaction_wr
    @table.update hash # this just updates the @table hash internally
  end
  alias insert update
  alias run transaction #instance of run and not self.run

  # returns the entire record as hash
  #
  #  ys = YAML::Store.new("c:\\data\\temp\\ystore.yml")
  #  record = {}
  #  ys.transaction do
  #    ys.record
  #  end
  #
  def record
    in_transaction
    @table.dup
  end

  # deletes yaml record from file.
  # returns roots arry of keys deleted
  def clear
    roots.each {|r| delete r}
  end

  # creates storage, executes initial transaction as needed
  # and returns instance of storage
  #
  #   ystore = YAML::Store.create("c:\\data\\temp\\ystore.yml") do |ys|
  #     ys[:bla] = bla
  #   end
  # record # =>
  def self.create( *o )
    ystore = self.new( *o )
    ystore.transaction do
      yield ystore
    end
    ystore
  end
end

#@ys = YAML::Store.new("c:\\data\\temp\\ystore.yml")
#
#puts @ys.inspect
#res = @ys.transaction do |ys|
#  ys.clear
#end
#puts res.inspect
#exit
##

#v = @ys.transaction do |ys|
#  ys[:deep] = {:bla => {:blamore => [1,2,3]}}
#  ys.update :blas => "someinfo"
#end
#puts "v is: #{v.inspect}"
#
#exit
#
#record = @ys.transaction do |ys|
#  ys.record
#end
#
#puts "and the final record is"
#puts record.inspect

require 'spec/autorun'

describe 'YAML::Store extensions' do

  before :all do
    @file = "c:\\data\\temp\\ystore.yml"
    @store = YAML::Store.new @file
  end

  before do
    @timestamp = Time.now.to_f
  end
  
  it 'create makes yaml file, transaction and returns ref to ystore' do
    v1 = @timestamp
    v2 = @timestamp
    ystore = YAML::Store.create(@file) do |ys|
      ys['bla'] = v1
      ys['foo'] = v2
    end

    ystore.should be_kind_of(YAML::Store)
    v = ystore.run do |ys|
      ys['bla']
    end
    v.should == v1

  end

  it 'record returns yaml record as hash' do

    ystore = YAML::Store.create(@file) do |ys|
      ys['bla'] = 'b'
      ys['foo'] = 'f'
    end

    rec = @store.run do |ys|
      ys.record
    end
    rec.keys.should == ['bla', 'foo']
    rec.values.should == ['b', 'f']
  
  end

  it 'clear removes all roots' do

    ystore = YAML::Store.create(@file) do |ys|
      ys.clear
    end

    rec = @store.run do |ys|
      ys.record
    end

    rec.should be_empty
  end

end