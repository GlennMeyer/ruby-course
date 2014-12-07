# TODO
module Library
  class BookRepo
    def self.all(db)
      db.exec("SELECT * FROM books ORDER BY id ASC;").to_a
    end

    def self.checkin(db, book_id)
      db.exec("INSERT INTO checkouts (user_id, status, book_id) VALUES (NULL, $1, $2);", ['returned', book_id])
    end

    def self.checkout(db, book_data)
      if book_data['status'] # Saves a book to checkout list.
        db.exec("INSERT INTO checkouts (book_id, status) VALUES ($1, $2);", [ book_data['book_id'], book_data['status']])
      else
        db.exec("INSERT INTO checkouts (user_id, status, book_id) VALUES ($1, $2, $3);", [book_data['user_id'], 'checked_out', book_data['book_id']])
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
        db.exec("SELECT b.title, c.status, c.created_at FROM checkouts c JOIN books b ON c.book_id = b.id WHERE c.book_id = $1 ORDER BY c.created_at DESC;", [book_id])
      else
        db.exec("SELECT b.id, b.title, c.status, c.created_at FROM checkouts c JOIN books b ON c.book_id = b.id ORDER BY c.created_at;")
      end
    end
  end
end