require 'rspec'
require 'stringio'

require 'rspec/core/formatters/progress_formatter'
# doesn't say so much about pending guys
class QuietPendingFormatter < RSpec::Core::Formatters::ProgressFormatter
  def example_pending(example)
    output.print yellow('*')
  end
end

require 'rspec/core/formatters/documentation_formatter'
class QuietPendingDocFormatter < RSpec::Core::Formatters::DocumentationFormatter
  def example_pending(example)
    output.puts yellow( "<pending>: #{example.execution_result[:pending_message]}" )
  end
end


RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.formatter = QuietPendingDocFormatter
  config.color = true
end

TESTFILES = File.dirname(__FILE__) + "/testfiles"

module Kernel
  # from: http://thinkingdigitally.com/archive/capturing-output-from-puts-in-ruby/
  def capture_stdout
    out = StringIO.new
    $stdout = out
    yield
    return out.string
  ensure
    $stdout = STDOUT
  end

  def capture_stderr
    out = StringIO.new
    $stderr = out
    yield
    return out.string
  ensure
    $stderr = STDERR
  end
end
