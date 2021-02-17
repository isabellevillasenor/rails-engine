require 'rails_helper'

describe 'Search API' do
  it 'returns a merchant based on search criteria' do
    merchant1 = create(:merchant, name: 'Hand-Spencer')
    merchant2 = create(:merchant, name: 'Ullrich-Moen')
    merchant3 = create(:merchant, name: 'Schuppe, Friesen and Schmeler')
    merchant4 = create(:merchant, name: 'Kutch, Blick and OKeefe')
    merchants = [merchant1.name, merchant2.name, merchant3.name]

    get '/api/v1/merchants/find_all?name=eN'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    merchant_names = json[:data].map do |merchant|
      merchant[:attributes][:name]
    end

    expect(merchant_names).to eq(merchants)
    expect(merchant_names).not_to include(merchant4)
  end

  it 'finds all items based on search criteria' do

  end
end