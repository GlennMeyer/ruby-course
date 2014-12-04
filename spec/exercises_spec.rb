require 'rspec'
require_relative '../exercises.rb'

# require 'spec-helper'
def capture_stdout(&block)
  $stdout = fake = StringIO.new
  original_stdout = $stdout
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end

describe 'Exercise 0' do
  it "triples the length of a string" do
    result = Exercises.ex0("ha")
    expect(result).to eq("hahaha")
  end

  it "returns 'nope' if the string is 'wishes'" do
    result = Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end
end

describe 'Exercise 1' do
  it "Returns the number of elements in the array" do
    result = Exercises.ex1("testtest")
    expect(result).to eq(8)
  end
end

describe 'Exercise 2' do
  it "Returns the second element of an array" do
    result = Exercises.ex2("abcdefgh")
    expect(result).to eq("b")
  end
end

describe 'Exercise 3' do
  it "Returns the sum of the given array of numbers" do
    result = Exercises.ex3([1,2,3,4,5,6,7,8,9,10])
    expect(result).to eq(55)
  end
end

describe 'Exercise 4' do
  it "Returns the max number of the given array" do
    result = Exercises.ex4([10,5,42,13,17,82,29,1])
    expect(result).to eq(82)
  end
end

describe 'Exercise 5' do
  it "Iterates through an array and `puts` each element" do
    output = capture_stdout{result = Exercises.ex5([1,2,3,4,5,6,7,8,9,10])}

    op = "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n"

    output.should == op
  end
end

describe 'Exercise 6' do
  it "Updates the last item in the array to 'panda'" do
    result = Exercises.ex6([1,2,3,4,5])
    expect(result).to eq([1,2,3,4,'panda'])
  end
  it "If the last item is already 'panda', update it to 'GODZILLA' instead" do
    result = Exercises.ex6([1,2,3,4,'panda'])
    expect(result).to eq([1,2,3,4,'GODZILLA'])
  end
end

describe 'Exercise 7' do
  it "If the string `str` exists in the array, add `str` to the end of the array" do
    result = Exercises.ex7([1,2,'str',4,5], 'str')
    expect(result).to eq([1,2,'str',4,5,'str'])
  end
end

describe 'Exercise 8' do
  it "`people` is an array of hashes. Each hash is like the following: { :name => 'Bob', :occupation => 'Builder' } Iterate through `people` and print out their name and occupation." do
    output = capture_stdout{result = Exercises.ex8([{ :name => 'Bob', :occupation => 'Builder' },{ :name => 'Dora', :occupation => 'The Explorer'}])}

    op = "{:name=>\"Bob\", :occupation=>\"Builder\"}\n{:name=>\"Dora\", :occupation=>\"The Explorer\"}\n"

    output.should == op
  end
end

describe 'Exercise 9' do
  it "Returns `true` if the given time is in a leap year." do
    result = Exercises.ex9(2000)
    expect(result).to eq(true)
  end

  it "Otherwise, returns `false`." do
    result = Exercises.ex9(1900)
    expect(result).to eq(false)
  end
end

describe 'Exercise 10' do
  it "Returns 'happy hour' if it is between 4 and 6pm. Otherwise, returns 'normal prices'" do
    # my_time = Time.now
    # allow(Time).to receive(:now).and_return(my_time)
    
    result = Exercises.ex10(Time.now)
    expect(result).to eq("normal prices")
  end
end

describe 'Exercise 11' do
  it "Returns the sum of two numbers if they are both integers" do
    result = Exercises.ex11(41, 96)
    expect(result).to eq(137)
  end
  it "Raises an error if both numbers are not integers" do
    expect{Exercises.ex11('NaN', nil)}.to raise_error
  end
end

describe 'Exercise 12' do
  it "Write a method that takes two characters and returns an ordered array with all characters need to fill the range" do
    result = Exercises.ex12('f', 'm')
    expect(result).to eq(['f', 'g', 'h', 'i', 'j', 'k', 'l', 'm'])
  end
end
