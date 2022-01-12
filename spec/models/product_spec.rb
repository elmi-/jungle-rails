require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @product = Product.new
    @category = Category.new
    @category.name = "Furniture"
    @product.name = "colour TV"
    @product.price_cents = 100.50
    @product.quantity = 5
    @product.category = @category
  end

  describe "Validations" do
    it "should validate Product" do  
      @product.save
      expect(@product).to be_valid
    end
    
    it "should validate Product name is nil" do
      @product.name = nil
      @product.save
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq("Name can't be blank")
    end
    
    it "should validate Product price is nil" do
      @product.price_cents = nil
      @product.save
      # byebug
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq("Price cents is not a number")
    end

    it "should validate Product price is nil" do
      @product.quantity = nil
      @product.save

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq("Quantity can't be blank")
    end

    it "should validate Product Category is nil" do
      @product.category = nil
      @product.save

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq("Category can't be blank")
    end
  end
end
