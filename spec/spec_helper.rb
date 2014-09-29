require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "simplecov"
SimpleCov.start do
  add_filter { |path| path.filename =~ /\.bundle|spec|vendor/ }
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "meal_plan"

RSpec.configure do |config|
  config.before do
    # silence warnings for doubled methods with no `desc`
    allow(Thor).to receive :create_command
  end

  config.raise_errors_for_deprecations!

  alias :evil :eval # rubocop:disable Alias
  def capture(stream)
    begin
      stream = stream.to_s
      evil "$#{stream} = StringIO.new"
      yield
      result = evil("$#{stream}").string
    ensure
      evil "$#{stream} = #{stream.upcase}"
    end

    result
  end
end
