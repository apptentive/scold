require_relative "../lib/scold.rb"

RSpec.describe Scold::Hounder do
  it "" do
    expect(described_class.run).to be 0
  end
end
