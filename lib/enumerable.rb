module Enumerable
  def my_each
    return self unless block_given?
    self.length.times do |index|
      yield self[index]
    end
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
