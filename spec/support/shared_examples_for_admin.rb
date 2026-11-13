# frozen_string_literal: true

RSpec.shared_examples "an admin" do |base_url|
  domain = URI.parse(base_url).host.sub(/\A[^.]+\./, "")

  let(:base_url) { base_url }

  def test_url(suffix)
    "#{base_url}/#{suffix}"
  end

  before do
    @admin = described_class.new("foo")
  end

  describe ".new" do
    it "requires a shop" do
      [nil, "", " "].each do |shop|
        expect { described_class.new(shop) }.to raise_error(ArgumentError, "shop required")
      end
    end

    it "accepts a fully qualified domain name" do
      admin = described_class.new("a.#{domain}")
      expect(admin.to_s).to eq "https://a.#{domain}/admin"
    end

    it "accepts a URL" do
      admin = described_class.new("http://a.#{domain}")
      expect(admin.to_s).to eq "http://a.#{domain}/admin"
    end

    it "accepts a shop name" do
      admin = described_class.new("foo")
      expect(admin.to_s).to eq base_url
    end
  end

  describe "#orders" do
    it "builds a URL to all orders" do
      expect(@admin.orders).to eq test_url("orders")
      expect(@admin.orders(:foo => "a b", :bar => 99)).to eq test_url("orders?foo=a+b&bar=99")
    end

    context "given an id" do
      it "builds a URL to an order" do
        expect(@admin.order(1)).to eq test_url("orders/1")
        expect(@admin.order(1, :foo => "a b", :bar => 99)).to eq test_url("orders/1?foo=a+b&bar=99")
      end
    end
  end

  describe "#products" do
    it "builds a URL to all products" do
      expect(@admin.products).to eq test_url("products")
      expect(@admin.products(:foo => "a b", :bar => 99)).to eq test_url("products?foo=a+b&bar=99")
    end

    context "given an id" do
      it "builds a URL to a product" do
        expect(@admin.product(1)).to eq test_url("products/1")
        expect(@admin.product(1, :foo => "a b", :bar => 99)).to eq test_url("products/1?foo=a+b&bar=99")
      end
    end
  end

  describe "#themes" do
    it "builds a URL to all themes" do
      expect(@admin.themes).to eq test_url("themes")
    end
  end

  describe "#theme" do
    it "builds a URL to the given theme" do
      expect(@admin.theme(1)).to eq test_url("themes/settings/installations/1")
      expect(@admin.theme(1, :foo => "a b", :bar => 99)).to eq test_url("themes/settings/installations/1?foo=a+b&bar=99")
    end

    it "requires an id" do
      [nil, "", " "].each do |id|
        expect { @admin.theme(id) }.to raise_error(ArgumentError, "id required")
      end
    end
  end
end

RSpec.shared_examples "an admin URL" do |base_url|
  it_behaves_like "an admin", base_url
end
