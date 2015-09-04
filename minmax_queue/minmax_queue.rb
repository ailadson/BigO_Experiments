require_relative "my_stack"

class MinMaxQueue
  def initialize
    @enqueue_stack = MyStack.new
    @dequeue_stack = MyStack.new
  end

  def enqueue(val)
    @enqueue_stack.push(val)
  end

  def dequeue
    transfer_stacks if @dequeue_stack.size.zero?
    @dequeue_stack.pop
  end

  def max
    if @enqueue_stack.max && @dequeue_stack.max
      [@enqueue_stack.max, @dequeue_stack.max].max
    elsif @enqueue_stack.max
      @enqueue_stack.max
    elsif @dequeue_stack.max
      @dequeue_stack.max
    end
  end

  def min
    if @enqueue_stack.min && @dequeue_stack.min
      [@enqueue_stack.min, @dequeue_stack.min].min
    elsif @enqueue_stack.min
      @enqueue_stack.min
    elsif @dequeue_stack.min
      @dequeue_stack.min
    end
  end

  def size
    @enqueue_stack.size + @dequeue_stack.size
  end

  private
  def transfer_stacks
    @enqueue_stack.size.times do
      @dequeue_stack.push(@enqueue_stack.pop)
    end
  end
end
