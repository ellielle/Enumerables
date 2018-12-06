require 'benchmark'
module Enumerable
  def my_each
    self.length.times do |index|
      yield self[index]
    end
    self    
  end

  def my_each_with_index
    self.length.times do |index|
      yield self[index], index
    end
    self
  end

  def my_select
    temp = []   
    self.my_each do |x|
      temp << x if yield(x)
    end
    temp
  end

  def my_all?
    self.my_each do |x|
      return false unless yield(x)
    end
    return true
  end

  def my_any?
    self.my_each do |x|
      return true if yield(x)
    end
    return false
  end

  def my_none?
    self.my_each do |x|
      if(block_given?)
        return yield(x) ? false : true
      else
        return false if(x)
      end
    end
    return true
  end

  def my_count
    count = 0
    self.my_each do |c|
      if(block_given?)
        count += 1 if yield(c)
      else
        count += 1
      end
    end
    count
  end

  def my_map(&proc)
    if block_given?
      new_arr = []
      self.length.times do |x|
        new_arr << (proc.call self[x])
      end
      new_arr
    else
      self.to_enum
    end
  end

  def my_inject(arg= nil)
    arg = self[0] unless arg
    if (block_given?)
      for x in 1..self.length-1
        value = self[x]
        arg = yield(arg, value)
      end
    else

    end
    arg
  end
end

def multiply_els(arr)
  arr.my_inject { |product, x| product * x }
end

#Everything below is for testing the methods

temp_nums = [23, 12, 73, 66, 82]
temp_alpha = ["abcde", "def", "ajk", "bjui", "zu"]
temp_none = [false, nil]
temp_nums.my_each { |x| print "#{x * 2}, " }
my_map_proc = Proc.new { |x| x < 30 }
my_map_proc2 = Proc.new { |x| x * 2}

puts
temp_nums.my_each_with_index { |value, index| print "#{index}: #{value}, " }
puts
p temp_alpha.my_select { |x| x =~ /[ab]/}
p temp_nums.my_select { |x| x < 50}
puts "my_all: "
puts temp_nums.my_all? { |x| x > 1 }
puts temp_nums.my_all? { |x| x > 30 }
puts "my_any?: "
puts temp_nums.my_any? { |x| x > 10 }
puts "my_none?: "
puts temp_nums.my_none? { |x| x < 100}
puts temp_nums.my_none?
puts temp_none.my_none?
puts "my_count: "
puts temp_nums.my_count { |x| x > 30 }
puts temp_nums.my_count
puts "my_map: "
p temp_nums.my_map { |x| x > 30 }
p temp_nums.my_map { |x| x.to_s }
p temp_nums.my_map
puts "my_map with proc test: "
p temp_nums.my_map(&my_map_proc)
p temp_nums.my_map(&my_map_proc2)
puts "my_inject: "
puts temp_nums.my_inject { |sum, n| sum + n }
puts "my_inject test with multiply_els: "
puts multiply_els([2, 4, 5]) #should return 40
puts multiply_els(temp_nums) #should return 109,040,976


