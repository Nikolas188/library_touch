# frozen_string_literal: true

require 'erb'

module Middlewares
  class Racker
    def initialize
      @library = Library.new
    end

    def call(env)
      request = Rack::Request.new(env)
      case request.path
      when '/' then respond(render('index.html.erb'))
      when '/authors', '/readers', '/books', '/orders'
        filename = request.path.delete('/')
        respond(render("#{filename}.html.erb"))
      else respond('Not Found', 404)
      end
    end

    private

    def render(template)
      path = File.expand_path("../lib/views/#{template}", __dir__)
      ERB.new(File.read(path)).result(binding)
    end

    def respond(*args)
      Rack::Response.new(*args).finish
    end
  end
end
