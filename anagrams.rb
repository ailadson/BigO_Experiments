require 'benchmark'

def first_anagram?(first_str, second_str) #n! + n -> O(n!)
  get_anagrams(first_str).include?(second_str)
end

def get_anagrams(str) #O(n!)
  return [str] if str.length == 1

  anagrams = []
  first_letter = str[0]
  get_anagrams(str[1..-1]).each do |ana|
    (0..ana.length).each do |i|
      anagrams << (ana[0...i] + first_letter + ana[i..-1])
    end
  end

  anagrams
end

def second_anagram?(first_str, second_str) # O(n^2)
  second_arr = second_str.split("")

  first_str.split("").each do |let|
    if second_arr.include?(let)
      idx = second_arr.index(let)
      second_arr.delete_at(idx)
    end
  end

  second_arr.empty?
end

def third_anagram?(first_str, second_str) #depends on sort. probably O(nlog(n))
  first_str.split("").sort == second_str.split("").sort
end

def fourth_anagram?(first_str, second_str) #O(n)
  first_hash = Hash.new {|h,k| h[k] = 0}
  second_hash = Hash.new {|h,k| h[k] = 0}

  first_str.split("").each do |l|
    first_hash[l] += 1
  end

  second_str.split("").each do |l|
    second_hash[l] += 1
  end

  second_hash == first_hash
end

#test
# p first_anagram?("gizmo", "sally")    #=> false
# p first_anagram?("elvis", "lives")    #=> true
#
# p second_anagram?("gizmo", "sally")    #=> false
# p second_anagram?("elvis", "lives")    #=> true
#
# p third_anagram?("gizmo", "sally")    #=> false
# p third_anagram?("elvis", "lives")    #=> true
#
# p fourth_anagram?("gizmo", "sally")    #=> false
# p fourth_anagram?("elvis", "lives")    #=> true

#benchmark
def run_benchmark(n)
  puts "Scale of #{n}"
  Benchmark.bm(14) do |x|
    if n > 2
      puts "O(n!)  ---  ommited for sake of brevity ---"
    else
      x.report("O(n!):"){ first_anagram?("elvis" * n, "lives" * n) }
    end
    x.report("O(n^2):"){ second_anagram?("elvis" * n, "lives" * n) }
    x.report("O(n*long(n)):"){ third_anagram?("elvis" * n, "lives" * n) }
    x.report("O(n):"){ fourth_anagram?("elvis" * n, "lives" * n) }
  end
  puts "\n\n"
end

run_benchmark(1)
run_benchmark(2)
run_benchmark(50)
run_benchmark(100)
run_benchmark(5000)
