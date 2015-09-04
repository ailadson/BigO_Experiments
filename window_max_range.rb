#naive
def windowed_max_range1(arr, w)
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
p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6
