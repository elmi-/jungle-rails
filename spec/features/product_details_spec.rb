require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  before :each do
    @category = Category.create! name: "Apparel"

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset("apparel1.jpg"),
        quantity: 10,
        price: 10.99
      )
    end
  end

  scenario "see product details" do
    # ACT
    visit product_path(@category)

    # DEBUG / VERIFY
    # save_screenshot
    save_and_open_screenshot
    
    # byebug

    expect(page).to have_content("Description")
  end
end
