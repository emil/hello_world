require 'minitest/autorun'
require_relative 'linked_list'

class LinkedListTest < MiniTest::Test
  def setup
  end

  def test_find_nth_to_last
    ll = LinkedList.new(0)
    10.times do |i| ll.add(i+1) end

    values = ll.return_list

    value_ints = values.map {|n| n.val}
    assert_equal 9, ll.nth_to_last(2).val
  end

  def test_add
    l1 = LinkedList.new(3)
    [1,5].each {|e| l1.add e}

    l2 = LinkedList.new(5)
    [9,2].each {|e| l2.add e}

    assert_equal [8,0,8], add_lists(l1.head,l2.head).return_list.map {|e| e.val}
  end
  
  def add_lists(l1, l2)
    carry = 0
    ll = nil
    
    while l1 != nil
      if ll.nil?
        ll = LinkedList.new(l1.val + l2.val + carry)
      else
        new_carry, val = (l1.val + l2.val).divmod(10)
        ll.add(val+carry)
        carry = new_carry
      end
      
      l1 = l1.next
      l2 = l2.next
    end
    ll
  end
  
end
