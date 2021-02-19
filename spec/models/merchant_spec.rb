require 'rails_helper'

describe Merchant do
 describe 'validations' do
  it { should validate_presence_of :name }
 end

 describe 'relationships' do
  it { should have_many :items }
  it { should have_many :invoices }
 end

 describe 'model methods' do
  before :each do 
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
  end

  it '#most_revenue' do
    merchants = Merchant.most_revenue('2')

    expect(merchants).to eq([@m2, @m3])
    end
  end

  it '#most_items' do
    merchants = Merchant.most_items('2')

    expect(merchants[0]).to eq(@m2)
    expect(merchants[1]).to eq(@m1)
  end
end
