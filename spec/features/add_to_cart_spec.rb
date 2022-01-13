require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
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

  scenario "cart changes from 0 to 1 after adding item to cart" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    click_on "Add", match: :first
    
    within('.navbar') { expect(page).to have_content(' My Cart (1)') }
    save_and_open_screenshot
  end
end
