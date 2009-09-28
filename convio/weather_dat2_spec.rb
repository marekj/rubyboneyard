# processes weather.dat
# a flat file space delimited monthly temperature records
class WeatherDat
  attr :all_dat, :dat_month

  def initialize
    load_all_dat
  end

  def days
    daily_temps.collect {|e| e[0]}
  end

  # returns record for the day
  # with lowest temp spread for that month
  def has_min_temp_spread
    daily_temps.min {|a,b| (a[1]-a[2]) <=> b[1]- b[2]}
  end

  # returns daily record with 3 elements
  # daynumber, max-temp and min-temp for that day
  def daily_temps
    day_min_max = dat_month.map {|e| e.split(" ")[0..2]}
    day_min_max.map { |e| e.map {|x| x.to_i }}
  end

  # returns collection of daily records for that month
  # each element is a daily line
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

  it "all_dat should be an array of lines from file" do
    @dat.all_dat.should be_a(Array)
  end

  it "dat_month holds 30 days of daily records" do
    @dat.dat_month.size.should == 30
  end

  it 'daily_temps is a collection of 30 records' do
    @dat.daily_temps.size.should == 30
  end

  it 'daily_temps each record has 3 elements day number and its max and min temps' do
    @dat.daily_temps.each { |e| e.size.should == 3 }
  end

  it 'daily_temps each element in each record is a number' do
    @dat.daily_temps.each do |e|
      e.each do |x|
        x.should be_a(Fixnum)
      end
    end
  end

  it 'daily_temps day1 sample record has numbers for day, max, min temps' do
    @dat.daily_temps.find {|e| e[0] == 1}.should == [1,88,59]
  end

  it "daily_temps for day9 with nonnumber as min_temp element" do
    @dat.daily_temps.find {|e| e[0] == 9}.should == [9, 86, 32]
  end

  it 'daily_temps for day26 with nonnumber in max_temp element' do
    @dat.daily_temps.find {|e| e[0] == 26}.should == [26, 97, 64]
  end

  it "days are numbers of dat_month from 1 to 30" do
    @dat.days.should == (1..30).to_a
  end


  it 'min_spread returns the record for the day and its spread' do
    @dat.has_min_temp_spread.should == [14, 61, 59]
  end

end

# example of usage
# dat = WeatherDat.new
# puts dat.has_min_temp_spread[0] # => 14