require 'blogger/commands/create'

RSpec.describe Blogger::Commands::Create do
  it "executes `create` command successfully" do
    output = StringIO.new
    options = {}
    command = Blogger::Commands::Create.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
