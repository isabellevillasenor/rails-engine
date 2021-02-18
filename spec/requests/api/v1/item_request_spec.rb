require 'rails_helper'

describe 'Item API Endpoints' do
  it 'should return an index of all items' do
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
    end

    expect(json[:data].count).to eq(7)
  end

  it 'should return data for one item' do
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

    expect(json[:data][:attributes]).not_to include(item2)
  end
end