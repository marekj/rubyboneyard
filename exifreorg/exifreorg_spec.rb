require 'spec/autorun'
require 'pp'
require 'exifr'
require 'fileutils'

class ExifReorg
  attr_reader :exifr, :file

  def initialize file
    @file  = File.expand_path(file)
    @exifr = EXIFR::JPEG.new(file)
  end

  def savepath
    "#{date[0]}/#{date[0]}-#{date[1]}/#{date[0]}-#{date[1]}-#{date[2]}/#{date.join("-")}#{camera_string}_#{originalname}"
  end

  def originalname
    File.basename(@file)
  end

  def camera_string
    camera == "" ? "" : "-#{camera.gsub(" ", "-")}"
  end

  def camera
    @camera ||= compute_camera
  end

  def compute_camera
    m = @exifr.model
    m.nil? ? "" : m.gsub('*', '').downcase
  end

  def date
    @date ||= date_string
  end

  def date_string
    d = @exifr.date_time
    if d.nil?
      'unknown unknown unknown'
    else
      d.strftime("%Y %m %d").split(" ")
    end
  end

  def date_unknown
    output "--- DATE UNKNOWN -- #{@file}"
  end

  def copy dest="."
    return date_unknown if date.include? "unknown"

    dest = File.join dest, savepath

    FileUtils.mkdir_p File.dirname(dest)
    if File.exists? dest
      output "EXISTS: #{dest}"
    else
      #output "created: #{dest}"
      FileUtils.cp @file, dest
    end
  end

  def output what
    pp what
  end
end

describe "ExifReorg" do

  before :all do
    f  = File.dirname(__FILE__) + "/rainbow.jpg"
    @e = ExifReorg.new(f)
  end

  it 'filelocation' do
    pp @e.file
  end

  it 'camera' do
    pp @e.camera
  end


  it 'date' do
    pp @e.date
  end

  it 'originaname' do
    pp @e.originalname
  end


  it "savepath" do
    f = __FILE__
    pp f
    pp @e.savepath
    pp @e.copy

  end

  it 'source' do
    files = Dir['../exifwork/iphone/**/*.jpg']
#    pp files
    pp files.size
    files.each do |f|
      begin
        e = ExifReorg.new f
        e.copy '../exifwork/'
      rescue => e
        pp '=======FAIL========'
        pp e
        pp f
        pp '================'
      end
    end

  end

end
