# frozen_string_literal: true

require "uri"
require_relative "tiendanube_url/version"

module TiendanubeURL
  DOMAIN = "mitiendanube.com"

  class Linker
    class Products < String
      def initialize(host, qs = nil)
        super host + "/products"
        self << "?" << qs if qs
      end
    end

    class Product < String
      def initialize(host, id, qs = nil)
        super host + "/products/" << id.to_s
        self << "?" << qs if qs
      end
    end

    class Orders < String
      def initialize(host, qs = nil)
        super host + "/orders"
        self << "?" << qs if qs
      end
    end

    class Order < String
      def initialize(host, id, qs = nil)
        super host + "/orders/" << id.to_s
        self << "?" << qs if qs
      end
    end

    def initialize(shop, domain)
      raise ArgumentError, "shop required" if empty?(shop)
      raise ArgumentError, "domain required" if empty?(domain)

      domain = domain.start_with?(".") ? domain : ".#{domain}"
      @host = shop.dup
      @host.prepend("https://") unless @host =~ %r{\Ahttps?://}i
      @host.chomp!("/")
      @host << domain unless @host.end_with?(domain)
      @host.freeze
    end

    def to_s
      @host.dup
    end

    alias to_str to_s
    alias inspect to_s

    def order(id, query = nil)
      id_required!(id)
      Order.new(host, id, q(query))
    end

    def orders(query = nil)
      Orders.new(host, q(query))
    end

    def product(id, query = nil)
      id_required!(id)
      Product.new(host, id, q(query))
    end

    def products(query = nil)
      Products.new(host, q(query))
    end

    def themes(query = nil)
      url = host + "/themes"
      url << "?" << q(query) if query
      url
    end

    protected

    attr_reader :host

    def id_required!(id)
      # Add caller to remove this frame from stack
      raise ArgumentError, "id required", caller if id.to_s.strip.empty?
    end

    def empty?(s)
      s.to_s.strip.empty?
    end

    def q(params)
      return unless params && params.respond_to?(:to_a)
      URI.encode_www_form(params.to_a)
    end
  end

  class Admin < Linker
    def initialize(shop)
      shop = shop.to_s.sub(%r{/admin/?\z}i, "") unless shop.nil?
      super(shop, DOMAIN)
      @host = (host + "/admin").freeze
    end
  end
end

module NuvemshopURL
  DOMAIN = "lojavirtualnuvem.com.br"
  VERSION = TiendanubeURL::VERSION

  class Admin < TiendanubeURL::Linker
    def initialize(shop)
      shop = shop.to_s.sub(%r{/admin/?\z}i, "") unless shop.nil?
      super(shop, DOMAIN)
      @host = (host + "/admin").freeze
    end
  end
end
