# processes weather.dat
# a flat file space delimited monthly temperature records
class WeatherDat
  attr :all_dat, :dat_month

  def initialize
    load_all_dat
  end

  def days
    dat_month.map {|e| e.split(" ")[0].to_i}
  end

  def max_temps
    dat_month.map {|e| e.split(" ")[1].to_i}
  end

  def min_temps
    dat_month.map {|e| e.split(" ")[2].to_i}
  end

  def min_spread
    daily_spreads.min do |a,b|
      a.last <=> b.last
    end
  end

  def daily_spreads
    x = []
    daily_temps.each {|e| x << [e[0], (e[1].to_i - e[2].to_i)]}
    x
  end

  def daily_temps
    day_min_max = dat_month.map {|e| e.split(" ")[0..2]}
    day_min_max.map { |e| e.map {|x| x.to_i }}
  end

  def dat_month
    @all_dat.select {|e| e.strip.match(/^[1-9]/)}
  end

  private
  def load_all_dat
    file = File.join(File.dirname(__FILE__), "weather.dat")
    @all_dat = []
    File.foreach(file) {|e| @all_dat << e}
  end
  
end


require "spec/autorun"

describe "WeatherDat" do

  before :all do
    @dat = WeatherDat.new
  end

  it "data should be an array of lines from file" do
    @dat.all_dat.should be_a(Array)
  end

  it "dat_month has 30 days of records daily record" do
    @dat.dat_month.size.should == 30
  end

  it "days are numbers of dat_month from 1 to 30" do
    @dat.days.should == (1..30).to_a
  end

  it "max_temps should be 30 elements" do
    @dat.max_temps.size.should == 30
  end

  it 'max_temps each should be a number' do
    @dat.max_temps.each do |e|
      e.should be_a(Integer)
    end
  end

  it "min_temps should be elements" do
    @dat.min_temps.size.should == 30
  end

  it 'min_temps each element should be a number' do
    @dat.min_temps.each do |e|
      e.should be_a(Integer)
    end
  end

  it 'daily_temps return records of day number and its max and min temps' do
    @dat.daily_temps.each do |e|
      e.size.should == 3
    end
  end

  it 'daily_spreads return records for day and its temp spread' do
    @dat.daily_spreads.each do |e|
      e.size.should == 2
    end
  end

  it 'min_spread returns the record for the day and its spread' do
    @dat.min_spread.should == [14, 2]
  end

end