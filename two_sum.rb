def bad_two_sum?(arr, target_sum) #O(n^2)
  arr.each_with_index do |num1, idx1|
    arr.each_with_index do |num2, idx2|
      break if idx1 == idx2
      return true if num2 + num1 == target_sum
    end
  end
  false
end

def okay_two_sum?(arr, target_sum) #O(nlog(n))
  arr = arr.sort

  arr.each_with_index do |ele, idx1|
    remaining = target_sum - ele
    idx = bsearch(arr, remaining)
    next if idx == idx1
    return true if idx
  end
  false
end

def bsearch(arr, target)
  pivot = arr.length/2

  if target == arr[pivot]
    return pivot
  elsif arr[pivot] && target < arr[pivot]
    return bsearch(arr[0...pivot], target)
  elsif arr[pivot] && target > arr[pivot]
    result = bsearch(arr[(pivot+1)..-1], target)
    return result + pivot + 1 if result
  end

  false
end

def pair_sum?(arr, target_sum) #O(n)
  counter = {}
  arr.each_with_index do |num, i|
    remaining = target_sum - num
    return true if counter[num] == remaining
    counter[remaining] = num
  end

  false
end
