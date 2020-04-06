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

end

def my_select

end

def my_all?

end

def my_any?

end

def my_none?	

end

def my_count	

end

def my_map	

end

def my_inject	

end

def my_map	

end