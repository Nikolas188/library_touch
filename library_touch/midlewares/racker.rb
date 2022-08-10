module Midlewares
  class Racker

    def initialize
      @library = library.new
    end

    def call(env)
      case env['PATH_INFO']
      when '/authors' then build_autors_page
      when '/books' then build_books_page
      when '/orders' then build_orders_page
      end
    end

    private

    def build_authors_page
      authors = @library.authors.map { |author| author.name }.uniq.join(', ')
      response(authors)
    end

    def build_reader_page
      reader = @library.reader.map { |reader| reader.mail }.uniq.join(', ')
      response(reader)
    end

    def build_books_page
      books = @library.orders.map { |book| book.title }.uniq.join(', ')
      response(orders)
    end

    def build_orders_page
      orders  @library.orders.map { |order| decorate_order(order) }.uniq.join(', ')
      response(orders)
    end

    def decorate_order(order)
      "#{order.author.name} - #{order.book.title}. #{order.date}. #{order.reader.emeil}"
    end

    def response(body)
    [200, { 'Content-Type' => 'text/html }, [body]]
    end
  end
end
