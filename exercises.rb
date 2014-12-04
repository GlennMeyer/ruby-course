
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    return "nope" if str == "wishes"
    str = str*3
  end

  # Exercise 1
  #  - Returns the number of elements in the array
  def self.ex1(array)
    # TODO
    array.length
  end

  # Exercise 2
  #  - Returns the second element of an array
  def self.ex2(array)
    # TODO
    array[1]
  end

  # Exercise 3
  #  - Returns the sum of the given array of numbers
  def self.ex3(array)
    # TODO
    sum = 0
    array.each{|i| sum += i}
    sum
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    # TODO
    array.sort.reverse.shift
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    # TODO
    array.each{|i| puts i}
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array)
    # TODO
    array[-1] == 'panda' ? array[-1] = 'GODZILLA' : array[-1] = 'panda'
    array
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    # TODO
    array << str if array.include?(str)
    array
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    # TODO
    people.each{|hash| puts hash}
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(year)
    # TODO
    ((year % 400 == 0 || year % 100 != 0) && year % 4 == 0) ? true : false
  end

  # Exercise 10
  #  - Returns "happy hour" if it is between 4 and 6pm
  #    Otherwise, returns "normal prices"
  # Hint: Read the "Stubbing" documentation on the Learn app.
  def self.ex10(time)
    # TODO
    time.to_s.slice(11, 2).to_i >= 16 && time.to_s.slice(11, 2).to_i <= 18 ? "happy hour" : "normal prices"
  end
  
  # Exercise 11
  #  - Returns the sum of two numbers if they are both integers
  #  - Raises an error if both numbers are not integers
  def self.ex11(num_one, num_two)
    # TODO
    # raise TypeError unless num_one.is_a?(Integer) && num_two.is_a?(Integer)
    num_one + num_two
  end
  
  # Exercise 12
  #  - Write a method that takes two characters and returns an
  #    ordered array with all characters need to fill the range
  #    Eg.
  #       Exercises.ex12('c', 'g') => ['c', 'd', 'e', 'f', 'g']
  def self.ex12(char_one, char_two)
    # TODO
    abc = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
    answer = []

    start = abc.index(char_one)
    fin = abc.index(char_two)

    for i in start..fin
      answer << abc[i]
    end
    answer
  end
end

module Extensions
  # Extension Exercise
  #  - Takes an `array` of strings. Returns a hash with two keys:
  #    :most => the string(s) that occures the most # of times as its value.
  #    :least => the string(s) that occures the least # of times as its value.
  #  - If any tie for most or least, return an array of the tying strings.
  #
  # Example:
  #   result = Extensions.extremes(['x', 'x', 'y', 'z'])
  #   expect(result).to eq({ :most => 'x', :least => ['y', 'z'] })
  #
  def self.extremes(array)
    # TODO
  end
end
