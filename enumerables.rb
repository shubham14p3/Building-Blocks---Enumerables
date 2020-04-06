module Enumerable
	def my_each
	  pos = 0
	  return to_enum unless block_given?
  
	  loop do
		break if pos >= length
  
		yield self[pos]
		pos += 1
	  end
	end

	def my_each_with_index
		pos = 0
		return to_enum unless block_given?
	
		loop do
		  break if pos >= length
	
		  yield self[pos], pos
		  pos += 1
		end
	  end

	  def my_select
		return_arr = []
		return to_enum unless block_given?
	
		my_each do |element|
		  return_arr.push(element) if yield element
		end
		return_arr
	  end

  def my_all?(arg = nil)
    return_val = true
    my_each do |element|
      return_val = (block_given? && yield(element)) || (arg === element)
      return_val = true?(element) if !block_given? && !arg
      return false unless return_val
    end
    return_val
  end


  def my_any?(arg = nil)
    return_val = false
    my_each do |element|
      return_val = (block_given? && yield(element)) || (arg === element)
      return_val = true?(element) if !block_given? && !arg
      return true if return_val
    end
    return_val
  end

  def my_none?(arg = nil)
    return_val = true
    my_each do |element|
      return_val = (block_given? && yield(element)) || (arg === element)
      return_val = true?(element) if !block_given? && !arg
      return false if return_val
    end
    true
  end


  def my_count(arg = nil)
    count_val = 0
    my_each do |element|
      count_val += 1 if ((block_given? && yield(element)) || (element === arg)) || (!block_given? && !arg)
    end
    count_val
  end

  def my_map(proc_arg = nil)
    return_arr = []
    my_each_with_index do |element, index|
      if proc_arg
        return_arr.push(proc_arg.call(element))
      elsif block_given?
        return_arr.push(yield(element))
      else
        return_arr.push(index)
      end
    end
    return return_arr unless !block_given? && !proc_arg
    return_arr.to_enum
  end

  def my_inject(*args)
    arr = to_a
    memo = args[0].is_a?(Symbol) ? arr[0] : args[0] || arr[0]
    symbol = identify_symbol(*args)
    pos = settle_start_position(*args)
    while pos < count
      memo = block_given? ? yield(memo, arr[pos]) : memo.send(symbol, arr[pos])
      pos += 1
    end
    memo
  end
end

def true?(val = nil)
	return false if val.nil? || !val
  
	true
  end

  def settle_start_position(*args)
	start_pos = 1
	start_pos = 0 if args[0] && !args[0].is_a?(Symbol)
	start_pos
  end

  def identify_symbol(*args)
	sym = nil
	if args.count == 2
	  sym = args[1]
	elsif args.count == 1
	  sym = args[0] if args[0].is_a?(Symbol)
	end
	sym
  end
  
  def multiply_els(arr)
	arr.my_inject(:*)
  end
  
  # The following lines are used for showcasing multiply_els, not for debugging purposes
puts 'multiply_els [1, 2, 3, 4, 5]:'
puts multiply_els([1, 2, 3, 4, 5])