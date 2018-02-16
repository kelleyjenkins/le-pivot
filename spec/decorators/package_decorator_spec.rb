require 'rails_helper'

RSpec.describe PackageDecorator do
  let(:item_1) { create(:item, price: 100.00) }
  let(:item_2) { create(:item, price: 100.00) }

  let(:cart) { Cart.new({"#{item_1.id}" => 2,  "#{item_2.id}" => 3})}

  subject {PackageDecorator.new(cart)}

  describe "#length" do
    it "fabricates a length" do
      expect(subject.length).to eq(13)
    end
  end
  describe "#width" do
    it "fabricates a width" do
      expect(subject.width).to eq(11)
    end
  end
  describe "#height" do
    it "fabricates a height" do
      expect(subject.height).to eq(5)
    end
  end
  describe "#weight" do
    it "fabricates a weight" do
      expect(subject.weight).to eq(5)
    end
  end


end
