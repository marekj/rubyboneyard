require 'pp'
require 'spec/autorun'

context "File.expand_path(pathname [, optionalstartingpoint])" do

  def parts path
    pp path
    path.split("/").slice(-4, 4)
  end

  specify "with ../pathname with __FILE__ as starting point" do
    p = File.expand_path "../path4", __FILE__
    parts(p).should == ["path1", "path2", "path3", "path4"]
  end

  specify "with /../pathname with __FILE__ as starting point disaster" do
    p = File.expand_path "/../path4", __FILE__
    parts(p).should_not == ["path1", "path2", "path3", "path4"]
  end

  specify "bad relpath given pathname only (this will not work)" do
    p = File.expand_path "path4", __FILE__
    parts(p).should == ["path2", "path3", "path_spec.rb", "path4"]
  end

  specify "bad relpath given with ./pathname (this will not work)" do
    p = File.expand_path "./path4", __FILE__
    parts(p).should == ["path2", "path3", "path_spec.rb", "path4"]
  end

  specify "incorrect usage starts with __FILE__ and rel start point" do
    p = File.expand_path __FILE__, "../path4"
    parts(p).should == ["path1", "path2", "path3", "path_spec.rb"]
=begin
calling from path1 this will fail with
expected: ["path1", "path2", "path3", "path_spec.rb"],
     got: ["path4", "path2", "path3", "path_spec.rb"] (using ==)
./path2/path3/path_spec.rb:28:
=end
  end

  specify "just this file" do
    p = File.expand_path __FILE__
    parts(p).should == ["path1", "path2", "path3", "path_spec.rb"]
  end
end