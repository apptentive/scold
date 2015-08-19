require_relative "../lib/scold.rb"

RSpec.describe Scold::Scolder do
  def cd(d, &_blk_required)
    Dir.chdir(File.expand_path("../#{d}", __FILE__)) { yield }
  end

  describe ".run" do
    before do
      stub_const("ENV", ENV.to_hash.merge("SCOLD_NO_STRICT" => "1"))
    end

    context "without custom .rubocop.yml" do
      around(:example) { |ex| cd("fixtures/simple") { ex.run } }

      it "rejects lines longer than 80 characters" do
        expect(described_class.run(%w(c90.rb))).not_to be 0
      end
    end

    context "with custom .rubocop.yml" do
      around(:example) { |ex| cd("fixtures/custom") { ex.run } }

      it "accepts lines shorter than 132 characters" do
        expect(described_class.run(%w(c90.rb))).to be 0
      end

      it "rejects lines longer than 132 characters" do
        expect(described_class.run(%w(c140.rb))).not_to be 0
      end
    end
  end
end
