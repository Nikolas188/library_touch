# frozen_string_literal: true

require './autoload'

author = Author.new('John Doe')
author1 = Author.new('Stephen King')
author2 = Author.new('Dan Brown')
author3 = Author.new('Ray Bradbury')

book = Book.new('Ruby', author)
book1 = Book.new('The Shining', author1)
book2 = Book.new('Deception Point', author2)
book3 = Book.new('451 Pharyngate', author3)

reader = Reader.new('Kek', 'email.com', 'city', 'street', 4)
reader1 = Reader.new('Bob', 'cool.com', 'Dnieper', 'Shevchenko', 3)
reader2 = Reader.new('Jack', 'dog.com', 'Dnieper', 'Victory', 2)
reader3 = Reader.new('Lol', 'cat.com', 'Dnieper', 'Peace', 1)

order = Order.new(book, reader, '22.06.2022')
order1 = Order.new(book1, reader, '24.06.2022')
order2 = Order.new(book2, reader, '25.06.2022')
order3 = Order.new(book, reader1, '26.06.2022')
order4 = Order.new(book, reader2, '26.06.2022')

library = Library.new
library.add(author)
library.add(author1)
library.add(author2)
library.add(author3)
library.add(book)
library.add(book1)
library.add(book2)
library.add(book3)
library.add(reader)
library.add(reader1)
library.add(reader2)
library.add(reader3)
library.add(order)
library.add(order1)
library.add(order2)
library.add(order3)
library.add(order4)
library.save

puts library.orders.first.book.title
puts library.orders.first.book.author.name
puts library.orders.first.reader.name
puts library.most_popular_book
puts library.the_best_reader
puts library.number_of_readers_of_most_popular_books
