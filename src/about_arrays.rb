require File.expand_path(File.dirname(__FILE__) + '/edgecase')

class AboutArrays < EdgeCase::Koan
  def test_creating_arrays
    empty_array = Array.new
    assert_equal __(Array), empty_array.class
    assert_equal __(0), empty_array.size
  end

  def test_array_literals
    array = Array.new
    assert_equal [], array # __

    array[0] = 1
    assert_equal [1], array     # __

    array[1] = 2
    assert_equal [1, __(2)], array

    array << 333
    assert_equal __([1, 2, 333]), array
  end

  def test_accessing_array_elements
    array = [:peanut, :butter, :and, :jelly]

    assert_equal __(:peanut), array[0]
    assert_equal __(:peanut), array.first
    assert_equal __(:jelly), array[3]
    assert_equal __(:jelly), array.last
    assert_equal __(:jelly), array[-1]
    assert_equal __(:butter), array[-3]
  end

  def test_slicing_arrays
    array = [:peanut, :butter, :and, :jelly]

    assert_equal __([:peanut]), array[0,1]
    assert_equal __([:peanut, :butter]), array[0,2]
    assert_equal __([:and, :jelly]), array[2,2]
    assert_equal __([:and, :jelly]), array[2,20]
    assert_equal __([]), array[4,0]
    assert_equal __([]), array[4,100]
    assert_equal __(nil), array[5,0]
  end

  def test_arrays_and_ranges
    assert_equal __(Range), (1..5).class
    assert_not_equal [1,2,3,4,5], (1..5) # __
    assert_equal __([1,2,3,4,5]), (1..5).to_a
    assert_equal __([1,2,3,4]), (1...5).to_a
  end

  def test_slicing_with_ranges
    array = [:peanut, :butter, :and, :jelly]

    assert_equal __([:peanut, :butter, :and]), array[0..2]
    assert_equal __([:peanut, :butter]), array[0...2]
    assert_equal __([:and, :jelly]), array[2..-1]
  end

  def test_pushing_and_popping_arrays
    array = [1,2]
    array.push(:last)

    assert_equal __([1, 2, :last]), array

    popped_value = array.pop
    assert_equal __(:last), popped_value
    assert_equal __([1, 2]), array
  end

  def test_shifting_arrays
    array = [1,2]
    array.unshift(:first)

    assert_equal __([:first, 1, 2]), array

    shifted_value = array.shift
    assert_equal __(:first), shifted_value
    assert_equal __([1, 2]), array
  end

  def test_adding_arrays
    array1 = [:peanut, :butter, :and, :jelly]
    array2 = [:bread, :and, :butter]

    assert_equal __([:peanut, :butter, :and, :jelly, :bread, :and, :butter]), array1 + array2
  end

  def test_subtracting_arrays
    array1 = [:peanut, :butter, :and, :jelly]
    array2 = [:bread, :and, :butter]

    assert_equal __([:peanut, :jelly]), array1 - array2
  end

  def test_intersecting_arrays
    array1 = [:peanut, :butter, :and, :jelly]
    array2 = [:bread, :and, :butter]

    assert_equal __([:butter, :and]), array1 & array2
  end

  def test_unionizing_arrays
    array1 = [:peanut, :butter, :and, :jelly]
    array2 = [:bread, :and, :butter]

    assert_equal __([:peanut, :butter, :and, :jelly, :bread]), array1 | array2
  end

  def test_getting_unique_elements
    array = [:peanut, :butter, :and, :jelly, :bread, :and, :butter]

    assert_equal __([:peanut, :butter, :and, :jelly, :bread]), array.uniq
  end

  def test_sorting_arrays
    array = ["cappuccino", "tea", "coffee", "smoothie", "latte"]

    assert_equal __([["cappuccino", "coffee", "latte", "smoothie", "tea"]]), array.sort
    assert_equal __(["tea", "smoothie", "latte", "coffee", "cappuccino"]), array.sort {|i, j| j <=> i}
    assert_equal __(["tea", "latte", "coffee", "smoothie", "cappuccino"]), array.sort {|i, j| i.length <=> j.length}
    assert_equal __(["cappuccino", "smoothie", "coffee", "latte", "tea"]), array.sort {|i, j| -i.length <=> -j.length}
  end

end
