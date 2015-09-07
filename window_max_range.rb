require "benchmark"

#naive
def naive_windowed_max_range(arr, w)
  current_max_range = 0
  arr.each_with_index do |el,i|
    window = arr[i...i+w]
    break if window.length < w
    diff = window.max - window.min
    current_max_range = diff if diff > current_max_range
  end
    current_max_range
  end

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
require "./minmax_queue/minmax_queue.rb"
#Implememnted using a home-brewed minmax queue

def windowed_max_range(arr, w)
  current_max_range = 0
  queue = MinMaxQueue.new

  arr.each do |num|
    queue.enqueue(num)
    queue.dequeue if queue.size > w
    if queue.size == w
      diff = queue.max - queue.min
      current_max_range = diff if diff > current_max_range
    end
  end
  current_max_range
end

#test
# p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
# p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6

def run_benchmark(n, w)
  arr = (0..n).to_a.shuffle
  Benchmark.bm(7) do |x|
    x.report("naive:"){ naive_windowed_max_range(arr, w) }
    x.report("minmax queue:"){ windowed_max_range(arr, w) }
  end
end

puts "small array | small window"
run_benchmark(500, 5)
puts "\n\n"

puts "small array | large window"
run_benchmark(500, 400)
puts "\n\n"

puts "large array | small window"
run_benchmark(50000, 20)
puts "\n\n"

puts "large array | large window"
run_benchmark(50000, 2000)
puts "\n\n"
