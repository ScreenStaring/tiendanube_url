require "spec_helper"

RSpec.describe TiendanubeURL::Linker do
  def test_url(suffix)
    "https://foo.mitiendanube.com/#{suffix}"
  end

  before do
    @linker = described_class.new("foo", "mitiendanube.com")
  end

  describe ".new" do
    it "requires a shop" do
      [nil, "", " "].each do |shop|
        expect { described_class.new(shop, "mitiendanube.com") }.to raise_error(ArgumentError, "shop required")
      end
    end

    it "requires a domain" do
      [nil, "", " "].each do |domain|
        expect { described_class.new("foo", domain) }.to raise_error(ArgumentError, "domain required")
      end
    end

    it "accepts a fully qualified domain name" do
      linker = described_class.new("a.mitiendanube.com", "mitiendanube.com")
      expect(linker.to_s).to eq "https://a.mitiendanube.com"
    end

    it "accepts a URL" do
      linker = described_class.new("http://a.mitiendanube.com", "mitiendanube.com")
      expect(linker.to_s).to eq "http://a.mitiendanube.com"
    end

    it "accepts a shop name" do
      linker = described_class.new("foo", "mitiendanube.com")
      expect(linker.to_s).to eq "https://foo.mitiendanube.com"
    end
  end

  describe "#orders" do
    it "builds a URL to all orders" do
      expect(@linker.orders).to eq test_url("orders")
      expect(@linker.orders(:foo => "a b", :bar => 99)).to eq test_url("orders?foo=a+b&bar=99")
    end

    context "given an id" do
      it "builds a URL to an order" do
        expect(@linker.order(1)).to eq test_url("orders/1")
        expect(@linker.order(1, :foo => "a b", :bar => 99)).to eq test_url("orders/1?foo=a+b&bar=99")
      end
    end
  end

  describe "#products" do
    it "builds a URL to all products" do
      expect(@linker.products).to eq test_url("products")
      expect(@linker.products(:foo => "a b", :bar => 99)).to eq test_url("products?foo=a+b&bar=99")
    end

    context "given an id" do
      it "builds a URL to a product" do
        expect(@linker.product(1)).to eq test_url("products/1")
        expect(@linker.product(1, :foo => "a b", :bar => 99)).to eq test_url("products/1?foo=a+b&bar=99")
      end
    end
  end

  describe "#themes" do
    it "builds a URL to all themes" do
      expect(@linker.themes).to eq test_url("themes")
    end
  end
end
