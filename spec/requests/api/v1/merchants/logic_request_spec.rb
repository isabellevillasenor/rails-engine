require 'rails_helper'

describe 'Merchants Logic API' do
  it 'can return merchants that have the most revenue' do
    @m1 = Merchant.create!(name: 'Merchant 1')
    @m2 = Merchant.create!(name: 'Merchant 2')
    @m3 = Merchant.create!(name: 'Merchant 3')
    @m4 = Merchant.create!(name: 'Merchant 4')
    @m5 = Merchant.create!(name: 'Merchant 5')

    @c1 = Customer.create!(first_name: 'Bilbo', last_name: 'Baggins')

    @invoice1 = Invoice.create!(status: 'shipped', customer: @c1, merchant: @m1)
    @invoice2 = Invoice.create!(status: 'shipped', customer: @c1, merchant: @m2)
    @invoice3 = Invoice.create!(status: 'shipped', customer: @c1, merchant: @m3)

    @item1 = Item.create!(name: 'Bow', description: 'Ranged Feather Pew Pew', unit_price: 10, merchant_id: @m1.id)
    @item2 = Item.create!(name: 'Sword', description: 'Pointy Pokey Boy/Girl', unit_price: 8, merchant_id: @m2.id)
    @item3 = Item.create!(name: 'Staff', description: 'Magical Stick', unit_price: 20, merchant_id: @m3.id)
    @item4 = Item.create!(name: 'Club', description: 'Angry Branch', unit_price: 2, merchant_id: @m4.id)
    @item5 = Item.create!(name: 'Axe', description: 'Chop Chop Stick', unit_price: 7, merchant_id: @m5.id)
    
    @ii1 = InvoiceItem.create!(quantity: 1, unit_price: 20, item: @item1, invoice: @invoice1)
    @ii2 = InvoiceItem.create!(quantity: 10, unit_price: 1000, item: @item2, invoice: @invoice2)
    @ii3 = InvoiceItem.create!(quantity: 5, unit_price: 5, item: @item3, invoice: @invoice3)

    @transaction1 = create(:transaction, invoice: @invoice1, credit_card_number: 203942)
    @transaction2 = create(:transaction, invoice: @invoice2, credit_card_number: 230948)
    @transaction3 = create(:transaction, invoice: @invoice3, credit_card_number: 234092)
    
    get '/api/v1/merchants/most_revenue?quantity=3'
    
    
    json = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful

    expect(json.length).to eq(3)

    expect(json[0][:attributes][:name]).to eq(@m2.name)
    expect(json[0][:id]).to eq(@m2.id.to_s)

    expect(json[1][:attributes][:name]).to eq(@m3.name)
    expect(json[1][:id]).to eq(@m3.id.to_s)

    expect(json[2][:attributes][:name]).to eq(@m1.name)
    expect(json[2][:id]).to eq(@m1.id.to_s)
  end
end