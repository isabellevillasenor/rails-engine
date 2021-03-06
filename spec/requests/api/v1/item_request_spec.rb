require 'rails_helper'

describe 'Item API Endpoints' do
  it 'can return an index of all items' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    create_list(:item, 3, merchant: merchant1)
    create_list(:item, 4, merchant: merchant2)

    get '/api/v1/items'

    expect(response).to be_successful
  
    json = JSON.parse(response.body, symbolize_names: true)

    json[:data].map do |item|
      expect(item[:attributes]).to have_key(:id)
      expect(item[:attributes][:id]).to be_an Integer

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a String

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a String

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a Float
    end

    expect(json[:data].count).to eq(7)
  end

  it 'can return data for one item' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)

    get "/api/v1/items/#{item1.id}"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:attributes]).to have_key(:id)
    expect(json[:data][:attributes][:id]).to be_an Integer

    expect(json[:data][:attributes]).to have_key(:name)
    expect(json[:data][:attributes][:name]).to be_a String

    expect(json[:data][:attributes]).to have_key(:description)
    expect(json[:data][:attributes][:description]).to be_a String

    expect(json[:data][:attributes]).to have_key(:unit_price)
    expect(json[:data][:attributes][:unit_price]).to be_a Float

    expect(json[:data][:attributes]).not_to include(item2)
  end

  it 'can create an item' do
    merchant = create(:merchant)
    body = { name: 'Corn Dog', description: 'Fried Yum Yum on a Stick', unit_price: 1.23, merchant_id: merchant.id }
    headers = { 'Content-Type' => 'application/json' }

    post '/api/v1/items', headers: headers, params: JSON.generate(body)

    expect(response).to be_successful

    expect(Item.last.name).to eq(body[:name])
    expect(Item.last.description).to eq(body[:description])
    expect(Item.last.unit_price).to eq(body[:unit_price])
    expect(Item.last.merchant_id).to eq(body[:merchant_id])
  end

  it 'can update an item' do
    item = create(:item)
    old_name = item.name

    patch "/api/v1/items/#{item.id}?name=Frostmourne"

    expect(response).to be_successful
    expect(Item.last.name).to eq('Frostmourne')
    expect(Item.last.name).to_not eq(old_name)
  end

  it 'can delete an item' do
    item = create(:item)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.all.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can return a merchant that is associated with an item' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    
    merchant2 = create(:merchant)
    item2 = create(:item, merchant: merchant2)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    
    expect(json[:data][:id].to_i).to eq(merchant.id)
    expect(json[:data][:id].to_i).to_not eq(merchant2.id)
  end
end