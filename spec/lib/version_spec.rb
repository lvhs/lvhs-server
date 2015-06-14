require 'rails_helper'
require 'version'

describe Version do
  let(:version) { Version.new(*args) }
  let(:args) { [1, 2, 3] }

  describe '#to_s' do
    let(:args) { [0, 0, 1] }
    it 'eql' do
      expect("#{version}").to eql "0.0.1"
    end
  end

  describe '#<=>' do
    it 'is larger compared by build ' do
      expect(version).to be > Version.new(1,2,0)
    end

    it 'is larger compared by minor ' do
      expect(version).to be > Version.new(1,0,3)
    end

    it 'is larger compared by major ' do
      expect(version).to be > Version.new(0,2,3)
    end
  end

  describe '.from_s' do
    it 'works fine' do
      expect(Version.from_s('1.2.3')).to eql Version.new(1,2,3)
    end
  end
end
