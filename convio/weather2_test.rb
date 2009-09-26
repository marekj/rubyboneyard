require "spec/autorun"

describe "Weather.dat Data File Processing" do

  before :all do
    file = File.join(File.dirname(__FILE__), "weather.dat")
    @data = []
    File.foreach(file) {|e| @data << e}
  end

  it "data should be an array of lines from file" do
    @data.should be_kind_of(Array)
  end

  context "extracting records for days of the month" do

    it "matching the first char of lines to numbers should return 30 records" do
      month_data = @data.select {|e| e.strip.match(/^[1-9]/)}
      month_data.size.should == 30
    end

    it "first col are numbers of days from 1 to 30" do
      month_data = @data.select {|e| e.strip.match(/^[1-9]/)}
      days = month_data.map {|e| e.split(" ")[0].to_i}
      days.should == (1..30).to_a
    end
  end

  context "getting first 3 columns from the days of the month records" do

    it "accessing frist 3 columns should return 3 elements in each row" do
      month_data = @data.select {|e| e.strip.match(/^[1-9]/)}
      day_max_min_records = month_data.map {|e| e.split(" ")[0..2]}
      day_max_min_records.each { |e| e.size.should == 3 }
    end

    it 'each element should to a number' do
      month_data = @data.select {|e| e.strip.match(/^[1-9]/)}
      day_max_min_records = month_data.map {|e| e.split(" ")[0..2]}

      res = day_max_min_records.map { |e| e.map {|x| x.to_i }}

      res.each do |e|
        e.each do |x|
          x.should be_a(Integer)
        end
      end

    end

  end


  it 'each element in col2 is transformed into integer' do
    max_temp = @data.select {|e| e.strip.match(/^[1-9]/)}.map {|e| e.split(" ")[1].to_i}
    max_temp.each {|e| e.should be_kind_of(Integer)}
  end

  it 'accessing third col returns 30 elements' do
    min_temp = @data.select {|e| e.strip.match(/^[1-9]/)}.map {|e| e.split(" ")[2].to_i}
    min_temp.size.should == 30
  end

  it 'each element in col3 is transformed into Integer' do
    min_temp = @data.select {|e| e.strip.match(/^[1-9]/)}.map {|e| e.split(" ")[2].to_i}
    min_temp.each {|e| e.should be_kind_of(Integer)}
  end

  it 'accessing 3 columns at once' do
    days = @data.select {|e| e.strip.match(/^[1-9]/)}.map {|e| e.split(" ")[0..2]}
   
  end



end