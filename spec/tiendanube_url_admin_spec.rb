# frozen_string_literal: true

require "spec_helper"

RSpec.describe TiendanubeURL::Admin do
  it_behaves_like "an admin", "https://foo.mitiendanube.com/admin"
end
