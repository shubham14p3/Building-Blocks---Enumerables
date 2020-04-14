require './enumerables'

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

  describe '#my_each_with_index' do
    it 'should return enum if no block given' do
      expect(numeric_arr.my_each_with_index).to be_a(Enumerator)
    end

    it 'should return the array itself when a block is passed' do
      expect(
        numeric_arr.my_each_with_index do |el, i|
        end
      ).to eql(numeric_arr)
    end

    it 'should not return nil when called on an empty Enumerable' do
      expect([].my_each_with_index).not_to eql(nil)
    end

    it 'should return the sum of all indexes of the array ' do
      sum = 0
      numeric_arr.my_each_with_index do |_el, i|
        sum += i
      end
      expect(sum).to eql(15)
    end
  end

  describe '#my_select' do
    it 'should return numbers greater than 5 on [1, 2, 3, 4, 5, 6]' do
      expect(
        numeric_arr.my_select do |el|
          el > 5
        end
      ).to eql([6])
    end

    it 'should return an empty array when called on an empty array' do
      expect(
        [].my_select do |_el|
          true
        end
      ).to eql([])
    end

    it 'should return an enumerator when no block is given' do
      expect(
        numeric_arr.my_select
      ).to be_a(Enumerator)
    end

    it 'should return an empty array when an empty block is passed' do
      expect(
        numeric_arr.my_select do
        end
      ).to eql([])
    end
  end

  describe '#my_all?' do
    it 'should test equality with the argument when an argument is passed' do
      expect(
        numeric_arr.my_all?(Integer)
      ).to eql(true)
    end

    it 'should return false if one of the elements is not equal to the argument' do
      expect(
        [1, 2, 4, 'hello'].my_all?(Integer)
      ).not_to eql(true)
    end

    it 'should not yield elements to the block when both an argument and a block are given' do
      expect(
        numeric_arr.my_all?(Integer) do
          false
        end
      ).to eql(true)
    end

    it 'should return true if all elements in the array are truthy, when no block and no argument are given' do
      expect(
        numeric_arr.my_all?
      ).to eql(true)
    end

    it 'should return false if at least one element in the array is falsey, when no block and no argument are given' do
      expect(
        [1, 2, 3, nil].my_all?
      ).not_to eql(true)
    end
  end

  describe '#my_any?' do
    it 'should yield elements to block, when a block is passed (any elements in the array > 5)' do
      expect(
        numeric_arr.my_any? do |el|
          el > 5
        end
      ).to eql(true)
    end

    it 'should return false if all of the elements are not equal to the argument (any strings in numeric_arr)' do
      expect(
        numeric_arr.my_any?(String)
      ).not_to eql(true)
    end

    it 'should not yield elements to the block when both an argument and a block are given' do
      expect(
        numeric_arr.my_any?(Integer) do
          false
        end
      ).to eql(true)
    end

    it 'should return true if any of the elements in the array are truthy, when no block and no argument are given' do
      expect(
        numeric_arr.my_any?
      ).to eql(true)
    end

    it 'should return false if all elements in the array are falsey, when no block and no argument are given' do
      expect(
        [false, false, nil, nil].my_any?
      ).not_to eql(true)
    end
  end

  describe '#my_none?' do
    it 'should yield elements to block, when a block is passed (no elements in the array > 5)' do
      expect(
        numeric_arr.my_none? do |el|
          el > 5
        end
      ).not_to eql(true)
    end

    it 'should return false if any of the elements in the array are equal to the argument' do
      expect(
        numeric_arr.my_none?(Numeric)
      ).not_to eql(true)
    end

    it 'should not yield elements to the block when both an argument and a block are given' do
      expect(
        numeric_arr.my_none?(String) do
          false
        end
      ).to eql(true)
    end

    it 'should return true if none of the elements in the array are truthy, when no block and no argument are given' do
      expect(
        numeric_arr.my_none?
      ).not_to eql(true)
    end

    it 'should return true if all elements in the array are falsey, when no block and no argument are given' do
      expect(
        [false, false, nil, nil].my_none?
      ).to eql(true)
    end
  end

  describe '#my_count' do
    it 'should return the number of elements that pass the validation given inside the block' do
      count = numeric_arr.my_count do |el|
        el > 4
      end
      expect(count).to eql(2)
    end

    it 'should return the number of elements that are equal to the argument' do
      count = numeric_arr.my_count(3)
      expect(count).to eql(1)
    end

    it 'should not yield elements to the block when both an argument and a block are given' do
      count = numeric_arr.my_count(3) do |_el|
        false
      end
      expect(count).to eql(1)
    end

    it 'should return the number of elements of the array when neither an argument and a block are not given' do
      count = numeric_arr.my_count
      expect(count).to eql(6)
    end

    it 'should return zero when an empty array calls the method' do
      count = [].my_count
      expect(count).to eql(0)
    end
  end

  describe '#my_map' do
    it 'should send the array to the proc, when both a proc and block are given' do
      res = numeric_arr.my_map(my_proc) do |element|
        element - 1
      end
      expect(res).to eql([2, 4, 6, 8, 10, 12])
    end

    it 'should return an Enumerator when neither a block or a proc are given' do
      expect(
        numeric_arr.my_map
      ).to be_a(Enumerator)
    end

    it 'should return an empty array when the sender is an empty array' do
      expect(
        [].my_map do
          true
        end
      ).to eql([])
    end
  end

  describe '#my_inject' do
    it 'should return the result of accumulating all the return values from the given block' do
      result = numeric_arr.my_inject do |memo, el|
        memo + el
      end
      expect(result).to eql(21)
    end

    it 'should return the result of accumulating all the return values from the given block using an initial value' do
      result = numeric_arr.my_inject(1) do |memo, el|
        memo + el
      end
      expect(result).to eql(22)
    end

    it 'should return the result of accumulating all the return values from the given symbol' do
      result = numeric_arr.my_inject(:+)
      expect(result).to eql(21)
    end

    it 'should return the result of accumulating all the return values from the given symbol using an initial value' do
      result = numeric_arr.my_inject(1, :+)
      expect(result).to eql(22)
    end

    it 'should only yield elements to the block when both a symbol and a block are given' do
      result = numeric_arr.my_inject(4, :+) do |memo, el|
        memo * el
      end
      expect(result).to eql(2880)
    end
  end
end
