# TODO
module Library
  class BookRepo
    def self.all(db)
      db.exec("SELECT * FROM books;").to_a
    end

    def self.checkout(db, book_data)
      if book_data['status']
        db.exec("INSERT INTO checkouts (book_id, status) VALUES ($1, $2);", [ book_data['book_id'], book_data['status']])
      else
        db.exec("UPDATE checkouts SET user_id = $1, status = $2 WHERE book_id = $3;", [book_data['user_id'], 'checked_out', book_data['book_id']])
      end
    end

    def self.find(db, book_id)
      db.exec("SELECT * FROM books WHERE id = $1;", [book_id])
    end

    def self.return(db, book_id)
      db.exec("UPDATE checkouts SET status = returned WHERE id = $1;", [book_id])
    end

    def self.save(db, book_data)
      if book_data['id']
        db.exec("UPDATE books SET title = $1, author = $2 WHERE id = $3 ;", [book_data['title'], book_data['author'],  book_data['id']])
      else
        db.exec("INSERT INTO books (title, author) VALUES ($1, $2);", [book_data['title'], book_data['author']])
      end
    end

    def self.status(db, book_id = nil)
      if book_id
        db.exec("SELECT b.title, c.status, u.name, c.created_at FROM checkouts c JOIN books b ON c.book_id = b.id JOIN users u ON u.id = c.user_id WHERE c.book_id = $1;", [book_id])
      else
        db.exec("SELECT b.title, c.status, u.name, c.created_at FROM checkouts c JOIN books b ON c.book_id = b.id JOIN users u ON u.id = c.user_id ORDER BY c.created_at;")
      end
    end
  end
end