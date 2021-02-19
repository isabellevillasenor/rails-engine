require 'rails_helper'

describe 'Items Search API' do
  it 'returns a list of items based on search criteria' do
    merchant = create :merchant
    merchant2 = create :merchant
    item1 = create(:item, name: 'Warcraft III', merchant: merchant)
    item2 = create(:item, name: 'Starcraft', merchant: merchant)
    item3 = create(:item, name: 'Minecraft', merchant: merchant2)
    item4 = create(:item, name: 'Final Fantasy XI', merchant: merchant2)

    get "/api/v1/items/find_all?name=cRaFt"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    items = json[:data].map do |item|
      item[:attributes][:name]
    end

    expect(items.count).to eq(3)
    expect(items).to eq([item1.name, item2.name, item3.name])
    expect(items).not_to include(item4.name)
  end

  it 'returns an item based on search criteria' do
    merchant = create :merchant
    item1 = create(:item, name: 'Warcraft III', merchant: merchant)
    item2 = create(:item, name: 'Starcraft', merchant: merchant)
    item3 = create(:item, name: 'Minecraft', merchant: merchant)

    get "/api/v1/items/find_one?name=CrAfT"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:attributes][:name]).to eq(item3.name)
  end
end
