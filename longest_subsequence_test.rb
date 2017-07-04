# -*- coding: utf-8 -*-
require 'minitest/autorun'


class LongestSubsequenceTest < MiniTest::Test
  def setup
  end

  def test_longest_sequence
    assert_equal 3, solution([6,10,6,9,7,8])
    assert_equal 4, solution([6,10,1,2,6,6,7])
    assert_equal 2, solution([5,5,3,3,9])
    assert_equal 4, solution([6,10,1,2,6,6,7])
    assert_equal 2, solution([5,6,3,2,1,4])
    assert_equal 6, solution([5, 5, 6, 6, 6, 7, 7, 7, 10])
    assert_equal 1, solution([0])
    assert_equal 2, solution([7,7])
    
  end
  
  def solution(a)
    return 0 if a.empty?
    
    # hash {array integer: count}
    h = a.inject({}) {|acc,e|  acc[e] = (acc[e] || 0) +1; acc }

    # special case, size 1
    return h.values.first if h.size == 1
    
    longest_sequence = 0
    
    h.keys.sort.each_cons(2) {|c|
      if 1+c.first == c.last # sequence : 5,6, 6,7, 7,8 etc
        ns = h[c.first] + h[c.last]
        longest_sequence = [ns,longest_sequence].max
      else # not sequence, check hash values (count)
        ns = [h[c.first], h[c.last]].max
        longest_sequence = [ns, longest_sequence].max
      end
    }
    longest_sequence
  end
  
  def solution_xxx(a)
    sorted_a = a.sort
    longest_sequence = 0
    
    previous = nil
    current_sequence = nil
    
    sorted_a.each {|e|
      if previous && (e == previous || e == previous+1)
        current_sequence += 1
        longest_sequence = [longest_sequence, current_sequence].max
      else
        current_sequence = 1
        previous = e
      end
    }
    longest_sequence
  end
end
