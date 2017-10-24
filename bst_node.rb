# -*- coding: utf-8 -*-
require 'stringio'

class BstNode
  attr_reader :value
  attr_accessor :left, :right

  def initialize(v)
    @value = v
  end

  def self.build_tree(values)
    root = BstNode.new(values.first)
    values[1...values.length].each {|e|
      n = root.insert(e)
    }
    root
  end
  
  def path(value)
    n = self
    node_path = []
    while !n.nil?
      node_path << n
      if n.value == value
        return node_path
      elsif n.value && n.value < value
        n = n.right
      elsif n.value && n.value > value
        n = n.left
      end
    end
    []
  end

  # Dist(n1, n2) = Dist(root, n1) + Dist(root, n2) - 2*Dist(root, lca) 
  # 'n1' and 'n2' are the two given keys
  # 'root' is root of given Binary Tree.
  #   'lca' is lowest common ancestor of n1 and n2
  # Dist(n1, n2) is the distance between n1 and n2.
  def distance(value1, value2)
    n1_path = path(value1)
    return -1 if n1_path.empty?
    n2_path = path(value2)
    return -1 if n2_path.empty?
    lca = n1_path & n2_path
    return -1 if lca.empty?
    n1_path.length + n2_path.length - (2* lca.length)
  end

  def depth(value)
    p = path(value)
    p.empty? ? -1 : p.length - 1
  end

  def level(value)
    p = path(value)
    p.empty? ? -1 : p.length
  end
  
  def insert(v)
    case value <=> v
    when 1 then insert_left(v)
    when -1 then insert_right(v)
    when 0 then false # the value is already present
    end
  end

  def size
    node_list = [self]
    list_size = 0
    
    loop do
      break if node_list.empty?
      n = node_list.pop
      list_size +=1
      node_list << n.left unless n.left.nil?
      node_list << n.right unless n.right.nil?
    end
    list_size
  end
  protected

  def insert_left(v)
    if left
      left.insert(v)
    else
      self.left = BstNode.new(v)
    end
  end

  def insert_right(v)
    if right
      right.insert(v)
    else
      self.right = BstNode.new(v)
    end
  end
end
