require "./lib/enumerable"

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
