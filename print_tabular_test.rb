# -*- coding: utf-8 -*-
require 'minitest/autorun'


class PrintTabularTest < MiniTest::Test
  
  def test_row_length_fits_array_length
    assert_equal(<<EOS.chomp, solution([4,35,80,123,12345,44,8,5], 10))
+-----+-----+-----+-----+-----+-----+-----+-----+
|    4|   35|   80|  123|12345|   44|    8|    5|
+-----+-----+-----+-----+-----+-----+-----+-----+
EOS
  end
  
  def test_row_length_short_fits_array_length_next_row
    assert_equal(<<EOS.chomp, solution([4,35,80,123,12345,44,8,5], 5))
+-----+-----+-----+-----+-----+
|    4|   35|   80|  123|12345|
+-----+-----+-----+-----+-----+
|   44|    8|    5|
+-----+-----+-----+
EOS
  end

  def test_row_length_div_array_length_no_reminder
    assert_equal(<<EOS.chomp, solution([4,35,80,123,12345,44,8,5,24,3,22,35], 4))
+-----+-----+-----+-----+
|    4|   35|   80|  123|
+-----+-----+-----+-----+
|12345|   44|    8|    5|
+-----+-----+-----+-----+
|   24|    3|   22|   35|
+-----+-----+-----+-----+
EOS
  end
  
  def test_row_length_is_two
    assert_equal(<<EOS.chomp, solution([4,35,80,123,12345,44,8,5,24,3], 2))
+-----+-----+
|    4|   35|
+-----+-----+
|   80|  123|
+-----+-----+
|12345|   44|
+-----+-----+
|    8|    5|
+-----+-----+
|   24|    3|
+-----+-----+
EOS
  end
  
  def test_row_length_is_one
    assert_equal(<<EOS.chomp, solution([4,35,80,123,12345,44,8,5,24,3], 1))
+-----+
|    4|
+-----+
|   35|
+-----+
|   80|
+-----+
|  123|
+-----+
|12345|
+-----+
|   44|
+-----+
|    8|
+-----+
|    5|
+-----+
|   24|
+-----+
|    3|
+-----+
EOS
  end

  def solution(n, k)
    mask_len = n.sort.last.to_s.length
    n_rows = n.length / k + (n.length % k == 0 ? 0 : 1)
    lines = []
    row = 0
    top_row = '+'+( (0...([k,n.length].min)).map {|e| '-' * mask_len }.join '+') + '+'
    n.each_slice(k) {|r|
      row +=1
      # top
      lines << top_row
      # row
      lines << '|'+(r.map {|e| sprintf "%#{mask_len}d", e}.join '|') + '|'
      # bottom
      if n_rows == row
        lines << '+'+(r.map {|e| '-' * mask_len }.join '+') + '+'
      end
    }
    
    lines.join "\n"
  end
end
