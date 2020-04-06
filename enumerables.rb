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

def my_map	

end

def my_inject	

end

def my_map	

end