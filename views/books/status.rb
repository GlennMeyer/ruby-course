<h1>Status:</h1>
<table>
<% @books.each do |book| %>
  <tr><td><%= book['id'] %></td><td><%= book['title'] %></td><td><%= book['author'] %></td><td><%= book['status'] %></td><td><%= book['borrower']%></td></tr>
<% end %>
</table>

<form method="POST" action="/checkout">
  <h3>Checkout Book</h3>
  <label>Borrower:</label>
  <input type="text" name="book_borrower" />
  <label>ID:</label>
  <input type="text" name="book_id" />
  <input type="submit" value="submit" />
</form>

<a href="/">Home</a>
<a href="/users">Manage Users</a>
<a href="/books">Manage Books</a>
<a href="/checkout">Checkout Book</a>