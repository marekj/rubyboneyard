
context "Examples For specdoc show fail formatter" do

  specify '1pass' do
    1.should == 1
  end

  specify "2fail" do
    "expectedtext".should == "actualtext"
  end

  specify '3pass' do
    2.should == 2
  end

end


=begin

regular specdoc shows this:

Examples For specdoc show fail formatter
- 1pass
- 2fail (FAILED - 1)
- 3pass

but we want to know immediately what failed and don't want to wait till the end of the run.
So it will output this

Examples For specdoc show fail formatter
- 1pass
- 2fail (FAILED - 1)
expected: "actualtext",
     got: "expectedtext" (using ==)
./output_spec.rb:9
- 3pass

1)
'Examples For specdoc show fail formatter 2fail' FAILED
expected: "actualtext",
     got: "expectedtext" (using ==)
./output_spec.rb:9:

Finished in 0.0 seconds

3 examples, 1 failure

=end
