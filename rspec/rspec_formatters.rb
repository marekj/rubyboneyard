require 'spec/runner/formatter/base_text_formatter'
# http://mentalized.net/journal/2008/10/16/immediatefeedbackformatter_better_formatted_rspec_output/
# Code is based on standard SpecdocFormatter, but will print full error details as soon as they are found.
# Successful or pending examples are written only as a dot in the output. Header is only printed if errors occur.
#
# To use it, add the following to your spec/spec.opts:
#  --require
#  lib/rspec_immediate_feedback_formatter.rb
#  --format
#  Spec::Runner::Formatter::ImmediateFeedbackFormatter

module Spec
  module Runner
    module Formatter
      class ImmediateFeedbackFormatter < BaseTextFormatter

        def add_example_group(example_group)
          super
          @current_group = example_group.description
        end

        def example_failed(example, counter, failure)
          if @current_group
            output.puts
            output.puts @current_group
            @current_group = nil  # only print the group name once
          end

          message = if failure.expectation_not_met?
            "- #{example.description} (FAILED - #{counter})"
          else
            "- #{example.description} (ERROR - #{counter})"
          end

          output.puts(failure.expectation_not_met? ? red(message) : magenta(message))
          dump_failure(counter, failure)  # dump stacktrace immediately
          output.flush
        end

        def example_passed(example)
          output.print green(".")
          output.flush
        end

        def example_pending(example, message)
          super
          output.print yellow(".")
          output.flush
        end
      end
    end
  end
end


require 'spec/runner/formatter/progress_bar_formatter'
# http://wiki.github.com/dchelimsky/rspec/custom-formatters
# spec spec --require spec/support/formatters/abort_on_first_failure_formatter.rb --format AbortOnFirstFailureFormatter
#

class AbortOnFirstFailureFormatter < Spec::Runner::Formatter::ProgressBarFormatter
  def example_failed(example, counter, failure)
    super
    @output.puts "Aborting after first failure"
    exit
  end
end
