class MyStack
  def initialize
    @store = []
  end

  def push(val)
    @store.push(create_minmax(val))
  end

  def pop
    @store.pop[:val]
  end

  def size
    @store.length
  end

  def peek
    @store[-1]
  end

  def max
    peek ? peek[:max] : nil
  end

  def min
    peek ? peek[:min] : nil
  end

  private
  def create_minmax(val)
    old_element = peek
    return { min: val, max: val, val: val } unless old_element
    {
      val: val,
      min: [old_element[:min], val].min,
      max: [old_element[:max], val].max
    }
  end
end
