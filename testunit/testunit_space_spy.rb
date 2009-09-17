require 'test/unit'
require 'watir/testcase'

module Test
  module Unit
    module SpaceSpy
  
      class << self
    
        # similar to Test::Unit::Collector::ObjectSpace.new.collect
        # returns collection of test suites in array sequentially for me
        def tests
          tests = []
          ObjectSpace.each_object(Class)do |klass| 
            if(Test::Unit::TestCase > klass)
              next if klass == Watir::TestCase
              next if klass.name == 'SpaceSpy'
              tests << klass.suite
            end
          end
          tests.reverse #TODO I don't know why I need to reverse this to have sequential here but I do
          # the ObjectSpace.#collect method sorts them it seams 
        end
    
        # returns collection of test suitess as array of arrays as records
        # [testcasename, [test_method1, test_method2]]
        def to_a
          out =[]
          tests.each do |test|
            rec =[];rec << test.name
            srec = [];test.tests.each {|tm| srec << tm.method_name};rec << srec
            out << rec
          end
          out
        end
  
        # returns to_a as yaml document helper method
        def to_yaml
          YAML.dump(to_a)
        end
      end    
    end
  end
end

