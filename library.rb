
class Book
  attr_accessor :id, :status, :borrower
  attr_reader :author, :title

  def initialize(title="", author="")
    @author = author
    @title = title
    @id = nil
    @status = "available"
    @borrower = ""
  end

  def check_out
    if @status == "available"
      @status = "checked_out"
      true
    else
      false
    end
  end

  def check_in
    @status = "available" if @status == "checked_out"
  end
end

class Borrower
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :books, :title, :author, :id
  attr_accessor :borrower, :status, :checkout_count

  def initialize(name = "")
    @books = []
    @count = 0
    @checkout_count = Hash.new(0)
  end

  def register_new_book(name, author)
    newbook = Book.new(name, author)
    # @count += 1
    newbook.id = (@count += 1)
    @books << newbook
  end

  # def books
  # end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    @books.each do |book|
      if @checkout_count[borrower] == 2 || (book.id == book_id && book.status == "checked_out") 
        return nil
      elsif book.id == book_id && book.status == "available"
        book.status = "checked_out"
        book.borrower = borrower
        @checkout_count[borrower] += 1
        return book
      end
    end
  end

  def get_borrower(book_id)
    @books.each{|book| return book.borrower.name if book.id == book_id }
  end

  def check_in_book(book)
    @books.each do |rental|
      if rental.title == book && rental.status == "checked_out"
        rental.status = "available"
        @checkout_count[rental.borrower] -= 1
        rental.borrower = ""
      end
    end
  end

  def available_books
    # available = []
    # available
    @books.select {|book| book.status == "available" }
  end

  def borrowed_books
    borrowed = []
    @books.each {|book| borrowed << book if book.status == "checked_out"}
    borrowed
  end
end
