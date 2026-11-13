# Tiendanube / Nuvemshop URL

[![CI](https://github.com/ScreenStaring/tiendanube_url/actions/workflows/ci.yml/badge.svg)](https://github.com/ScreenStaring/tiendanube_url/actions/workflows/ci.yml)

Build URLs to Tiendanube and Nuvemshop web pages.

## Usage

### Admin URLs

```ruby
require "tiendanube_url"

# Tiendanube (mitiendanube.com)
url = TiendanubeURL::Admin.new("shopname")

# https://shopname.mitiendanube.com/admin
url.to_s

# https://shopname.mitiendanube.com/admin/orders
url.orders

# https://shopname.mitiendanube.com/admin/orders/123
url.order(123)

# https://shopname.mitiendanube.com/admin/products
url.products

# https://shopname.mitiendanube.com/admin/products/456
url.product(456)

# https://shopname.mitiendanube.com/admin/themes
url.themes
```

```ruby
# Nuvemshop (lojavirtualnuvem.com.br)
url = NuvemshopURL::Admin.new("shopname")

# https://shopname.lojavirtualnuvem.com.br/admin
url.to_s

# https://shopname.lojavirtualnuvem.com.br/admin/orders
url.orders

# https://shopname.lojavirtualnuvem.com.br/admin/orders/123
url.order(123)

# https://shopname.lojavirtualnuvem.com.br/admin/products
url.products

# https://shopname.lojavirtualnuvem.com.br/admin/products/456
url.product(456)

# https://shopname.lojavirtualnuvem.com.br/admin/themes
url.themes
```

### Custom Linker

`TiendanubeURL::Linker` can be used directly by supplying a shop and domain:

```ruby
url = TiendanubeURL::Linker.new("shopname", "customdomain.com")

# https://shopname.customdomain.com
url.to_s

# https://shopname.customdomain.com/products
url.products
```

### Query String Parameters

All URL generation methods accept a `Hash` of query string parameters:

```ruby
url = TiendanubeURL::Admin.new("shopname")

# https://shopname.mitiendanube.com/admin/products?page=2&per_page=50
url.products(:page => 2, :per_page => 50)
```

## See Also

[Shopify URL](https://github.com/ScreenStaring/shopify_url) - Build URLs to Shopify web pages

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

---

Made by [ScreenStaring](https://screenstaring.com)
