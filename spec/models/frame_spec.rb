require 'rails_helper'

RSpec.describe Frame, type: :model do
  let(:strike) { FactoryGirl.create(:frame, :strike) }
  let(:spare) { FactoryGirl.create(:frame, :spare) }
  let(:open) { FactoryGirl.create(:frame, :open) }
  let(:twelfth) { FactoryGirl.create(:frame, :twelfth, first: 8) }
  let(:eleventh) do
    FactoryGirl.create(:frame, :eleventh, first: 8, second: 2)
  end

  describe 'validations' do
    let(:frame) { FactoryGirl.create(:frame) }
    describe 'first' do
      it 'requires presence' do
        frame.first = nil
        expect(frame.valid?).to eq false
      end
      it 'matches a first frame format' do
        frame.first = 'F'
        expect(frame.valid?).to eq true
        frame.first = 'f'
        expect(frame.valid?).to eq true
        frame.first = '0'
        expect(frame.valid?).to eq true
        frame.first = '1'
        expect(frame.valid?).to eq true
        frame.first = '2'
        expect(frame.valid?).to eq true
        frame.first = '3'
        expect(frame.valid?).to eq true
        frame.first = '4'
        expect(frame.valid?).to eq true
        frame.first = '5'
        expect(frame.valid?).to eq true
        frame.first = '6'
        expect(frame.valid?).to eq true
        frame.first = '7'
        expect(frame.valid?).to eq true
        frame.first = '8'
        expect(frame.valid?).to eq true
        frame.first = '9'
        expect(frame.valid?).to eq true
        frame.first = '10'
        expect(frame.valid?).to eq true
        frame.first = '11'
        expect(frame.valid?).to eq false
        frame.first = 'S1'
        expect(frame.valid?).to eq true
        frame.first = 's3'
        expect(frame.valid?).to eq true
        frame.first = 's10'
        expect(frame.valid?).to eq false
        frame.first = 'S11'
        expect(frame.valid?).to eq false
        frame.first = '12'
        expect(frame.valid?).to eq false
        frame.first = 'f5'
        expect(frame.valid?).to eq false
        frame.first = 'F6'
        expect(frame.valid?).to eq false
      end
    end

    describe 'second' do
      it 'matches a second frame format' do
        frame.second = 'F'
        expect(frame.valid?).to eq true
        frame.second = 'f'
        expect(frame.valid?).to eq true
        frame.second = '0'
        expect(frame.valid?).to eq true
        frame.second = '1'
        expect(frame.valid?).to eq true
        frame.second = '2'
        expect(frame.valid?).to eq true
        frame.second = '3'
        expect(frame.valid?).to eq true
        frame.second = '4'
        expect(frame.valid?).to eq true
        frame.second = '5'
        expect(frame.valid?).to eq true
        frame.second = '6'
        expect(frame.valid?).to eq true
        frame.second = '7'
        expect(frame.valid?).to eq true
        frame.second = '8'
        expect(frame.valid?).to eq true
        frame.second = '9'
        expect(frame.valid?).to eq true
        frame.second = '10'
        expect(frame.valid?).to eq true
        frame.second = '11'
        expect(frame.valid?).to eq false
        frame.second = 'S1'
        expect(frame.valid?).to eq false
        frame.second = 's3'
        expect(frame.valid?).to eq false
        frame.second = 's10'
        expect(frame.valid?).to eq false
        frame.second = 'S11'
        expect(frame.valid?).to eq false
        frame.second = '12'
        expect(frame.valid?).to eq false
        frame.second = 'f5'
        expect(frame.valid?).to eq false
        frame.second = 'F6'
        expect(frame.valid?).to eq false
      end
    end

    describe 'frame' do
      it 'requires presence' do
        frame.frame = nil
        expect(frame.valid?).to eq false
      end
      it 'must be an integer between 1 and 12' do
        frame.frame = 0
        expect(frame.valid?).to eq false
        frame.frame = 13
        expect(frame.valid?).to eq false
        frame.frame = 12
        expect(frame.valid?).to eq true
        frame.frame = 1
        expect(frame.valid?).to eq true
        frame.frame = 4
        expect(frame.valid?).to eq true
        frame.frame = 4.5
        expect(frame.valid?).to eq false
      end
    end
  end

  describe '#total' do
    it 'returns the total of the frame' do
      expect(strike.total).to eq 10
      expect(spare.total).to eq 10
      expect(open.total).to eq 9
      expect(twelfth.total).to eq 8
      expect(eleventh.total).to eq 10
    end
  end

  describe '#strike?' do
    it 'returns true on a strike' do
      expect(strike.strike?).to eq true
    end

    it 'returns false on a spare' do
      expect(spare.strike?).to eq false
    end

    it 'returns false on an open' do
      expect(open.strike?).to eq false
    end
  end

  describe '#spare?' do
    it 'returns false on a strike' do
      expect(strike.spare?).to eq false
    end

    it 'returns true on a spare' do
      expect(spare.spare?).to eq true
    end

    it 'returns false on an open' do
      expect(open.spare?).to eq false
    end
  end

  describe '#open?' do
    it 'returns false on a strike' do
      expect(strike.open?).to eq false
    end

    it 'returns false on a spare' do
      expect(spare.open?).to eq false
    end

    it 'returns true on an open' do
      expect(open.open?).to eq true
    end
  end

  describe '#fill?' do
    it 'returns true on a strike' do
      expect(strike.fill?).to eq true
    end

    it 'returns true on a spare' do
      expect(spare.fill?).to eq true
    end

    it 'returns false on an open' do
      expect(open.fill?).to eq false
    end
  end

  describe '#twelfth?' do
    it 'returns true on the twelfth frame' do
      expect(twelfth.twelfth?).to eq true
    end
    it 'returns false on anything but the twelfth frame' do
      expect(strike.twelfth?).to eq false
      expect(eleventh.twelfth?).to eq false
    end
  end

  describe '#eleventh?' do
    it 'returns true on the eleventh frame' do
      expect(eleventh.eleventh?).to eq true
    end
    it 'returns false on anything but the eleventh frame' do
      expect(twelfth.eleventh?).to eq false
      expect(strike.eleventh?).to eq false
    end
  end

  describe '#convert_first' do
    let(:frame) { FactoryGirl.create(:frame) }
    it 'handles numbers' do
      frame.first = '10'
      expect(frame.convert_first).to eq 10
      frame.first = '3'
      expect(frame.convert_first).to eq 3
    end

    it 'handles splits' do
      frame.first = 's8'
      expect(frame.convert_first).to eq 8
      frame.first = 'S3'
      expect(frame.convert_first).to eq 3
    end

    it 'handles fouls' do
      frame.first = 'F'
      expect(frame.convert_first).to eq 0
      frame.first = 'f'
      expect(frame.convert_first).to eq 0
    end
  end
end
