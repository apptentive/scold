require_relative "../lib/scold.rb"

RSpec.describe Scold::Scolder do
  describe ".run" do
    context "without custom .rubocop.yml" do
      around(:example) do |ex|
        Dir.chdir(File.expand_path("../fixtures/simple", __FILE__)) { ex.run }
      end

      it "rejects lines longer than 80 characters" do
        expect(described_class.run(%w(c90.rb))).to be 1
      end
    end

    context "with custom .rubocop.yml" do
      around(:example) do |ex|
        Dir.chdir(File.expand_path("../fixtures/custom", __FILE__)) { ex.run }
      end

      it "accepts lines shorter than 132 characters" do
        expect(described_class.run(%w(c90.rb))).to be 0
      end

      it "rejects lines longer than 132 characters" do
        expect(described_class.run(%w(c140.rb))).to be 1
      end
    end
  end
end
