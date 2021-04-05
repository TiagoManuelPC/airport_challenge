require 'airport'
describe Airport do
  subject(:airport) { described_class.new } 
  let(:plane) { double :plane }
  let(:airport) { Airport.new(2) }
  let(:plane) { Plane.new }
   
  describe '#land' do

    context 'when not stormy' do

      before do
        allow(airport).to receive(:stormy?).and_return false
      end

      it 'responds to land' do
        expect(airport).to respond_to(:land).with(1).argument 
      end

      it 'lands a plane' do 
        expect(airport.land(plane)).to eq([plane])
      end

      context 'when full' do

        it 'raises an error' do
          2.times { airport.land(plane) }
          expect { airport.land(plane) }.to raise_error('Airport full:take of a plane to land this one') 
        end
      end
    end

    context 'when storm' do

      it 'doesnt allow landings ' do
        allow(airport).to receive(:stormy?).and_return true
        expect { airport.land(plane) }.to raise_error('cant land, is stormy')
      end
    end
  end
  
  describe '#take of' do

    context 'when not stormy' do

      before do 
        allow(airport).to receive(:stormy?).and_return false
      end
    
      it 'responds to take of' do
        expect(airport).to respond_to(:take_of).with(1).argument 
      end
      it 'takes-of a plane' do 
        @planes = []
        airport.land(plane)
        @planes << plane
        airport.take_of(plane)
        @planes.delete(plane)
        expect(@planes).not_to include(plane)
      end

      it 'confirms that plane is no longer at the airport' do
        @planes = []
        plane = Plane.new
        airport.land(plane)
        @planes << plane
        expect(airport.take_of(plane)).to eq(plane)  
      end
    end

    context 'when stormy' do

      it 'doesnt allow take ofs ' do
        allow(airport).to receive(:stormy?).and_return true
        expect { airport.take_of(plane) }.to raise_error('cant take of, is stormy')
      end
    end
  end
end   
