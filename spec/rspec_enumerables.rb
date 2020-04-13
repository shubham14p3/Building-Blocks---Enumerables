RSpec.describe 'Enumerable' do
  let(:numeric_arr) { [1, 2, 3, 4, 5, 6] }

  let(:my_proc) { proc { |el| el * 2 } }

  describe '#my_each' do
    it 'should return enum if no block given' do
      expect(numeric_arr.my_each).to be_a(Enumerator)
    end

    it 'should return the array itself when a block is passed' do
      expect(
        numeric_arr.my_each do |el|
        end
      ).to eql(numeric_arr)
    end

    it 'should not return nil when called on an empty Enumerable' do
      expect([].my_each).not_to eql(nil)
    end

    it 'should return the sum of all elements in the array' do
      sum = 0
      numeric_arr.my_each do |el|
        sum += el
      end
      expect(sum).to eql(21)
    end
  end 
end