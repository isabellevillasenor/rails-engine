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
    end

    expect(json[:data].count).to eq(7)
  end
end