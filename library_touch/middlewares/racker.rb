# frozen_string_literal: true

require 'erb'

module Middlewares
  class Racker
    def initialize
      @library = Library.new
    end

    def call(env)
      request = Rack::Request.new(env)
      case request.request_method
      when 'GET' then process_get_request(request)
      when 'POST' then process_post_request(request)
      else respond('Bad Request', 400)
      end
    end

    private

    def process_get_request(request)
      case request.path
      when '/' then respond(render('index.html.erb'))
      when '/authors', '/readers', '/books', '/orders'
        filename = request.path.delete('/')
        respond(render("#{filename}.html.erb"))
      else respond('Not Found', 404)
      end
    end

    def process_post_request(request)
      case request.path
      when '/authors' then create_author(request.params)
      when '/books' then create_book(request.params)
      when '/orders' then create_order(request.params)
      when '/readers' then create_reader(request.params)
      else respond('Bad Request', 400)
      end
    end

    def create_author(params)
      author = Author.new(params['name'], params['biography'])
      @library.add(author)
      @library.save
      respond(render('authors.html.erb'))
    end

    def create_book(params)
      author = @library.authors.find { |author| author.name == params['author'] }
      book = Book.new(params['title'], author)
      @library.add(book)
      @library.save
      respond(render('books.html.erb'))
    end

    def create_reader(params)
      reader = Reader.new(params['name'], params['street'], params['email'],
                          params['city'], params['house'].to_i)
      @library.add(reader)
      @library.save
      respond(render('readers.html.erb'))
    end

    def create_order(params)
      book = @library.books.find { |book| book.title == params['book'] }
      reader = @library.readers.find { |reader| reader.email == params['reader'] }
      order = Order.new(book, reader, params['date'])
      @library.add(order)
      @library.save
      respond(render('orders.html.erb'))
    end

    def render(template)
      path = File.expand_path("../lib/views/#{template}", __dir__)
      ERB.new(File.read(path)).result(binding)
    end

    def respond(*args)
      Rack::Response.new(*args).finish
    end
  end
end
