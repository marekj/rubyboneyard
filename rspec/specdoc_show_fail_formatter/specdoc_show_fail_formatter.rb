require 'spec/runner/formatter/specdoc_formatter'

class SpecdocShowFailFormatter < Spec::Runner::Formatter::SpecdocFormatter
  def example_failed(example, counter, failure)
    super
    output.puts "#{failure.exception}"
    output.puts failure.exception.backtrace
    output.flush
  end
end
