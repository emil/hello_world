class Node
  attr_accessor :val, :next

  def initialize(val, next_node)
    @val = val
    @next = next_node
  end
end

class LinkedList
  attr_reader :head
  
  def initialize(val)
    @head = Node.new(val, nil)
  end

  def add(val)
    current = @head
    while current.next != nil
      current = current.next
    end
    current.next = Node.new(val, nil)
  end

  def delete(val)
    current.next = @head
    if current.val = val
      @head = current.next
    else
      while (current.next != nil) && (current.next.val != val)
        current = current.next
      end
      unless current.next == nil
        current.next = current.next.next
      end
    end
  end

  def return_list
    elements = []
    current = @head
    while current.next != nil
      elements << current
      current = current.next
    end
    elements << current
  end

  def nth_to_last(nth)
    return nil if nth < 1
    
    p2 = @head
    n = 0
    
    while p2.next != nil && n < nth
      p2 = p2.next
      n +=1
    end
    return nil if n < nth -1

    p1 = @head
    while p2 != nil
      p1 = p1.next
      p2 = p2.next
    end
    p1
  end
  
end
