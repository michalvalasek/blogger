RSpec.describe "`blogger create` command", type: :cli do
  it "executes `blogger help create` command successfully" do
    output = `blogger help create`
    expected_output = <<-OUT
Usage:
  blogger create

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
