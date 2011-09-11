require 'pp'

class Foo

  def with_retry_times (retries=3)
    tries = 0
    begin
      tries += 1
      pp "trying: #{tries}"
      yield
    rescue
      pp $!
      retry if tries < retries
      pp "giving up after: #{tries}"
    end
  end

end


c = Foo.new

c.with_retry_times 3 do
  fail 'miserably'
end


class Bar

  def redo retries=3
# why will this never work?
    1.upto(retries) do |i|
      begin
        pp "trying"
        fail 'bla'
      rescue
        retry if i < retries
        pp 'giving up'
      end
    end

  end
end

#Bar.new.redo 3
