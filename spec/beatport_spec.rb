require 'spec_helper'

describe Beatport do
  describe '.const_missing' do
    it "returns the constant within Catalog if it exists there" do
      silence_stream($stderr) do
        track = Beatport::Track.new
        track.should be_a(Beatport::Catalog::Track)
      end
    end

    it "raises an NameError if the constant doesn't exist with Catalog" do
      lambda { Beatport::Foo.new }.should raise_error(NameError, "uninitialized constant Beatport::Foo")
    end
  end
end
