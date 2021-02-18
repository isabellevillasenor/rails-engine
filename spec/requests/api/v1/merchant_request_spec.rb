require 'rails_helper'

describe 'Merchant API Endpoints' do
  it 'should return an index of all merchants' do
    create_list(:merchant, 4)

    get '/api/v1/merchants'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    json[:data].map do |merchant|
      expect(merchant[:attributes]).to have_key(:id)
      expect(merchant[:attributes][:id]).to be_an Integer

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a String
    end
  end

  it 'should return data for one merchant' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    create_list(:item, 2, merchant: merchant1)
    create(:item, merchant: merchant2)

    get "/api/v1/merchants/#{merchant1.id}"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:attributes][:id]).to eq(merchant1.id)

    expect(json[:data][:attributes]).to have_key(:id)
    expect(json[:data][:attributes][:id]).to be_an Integer

    expect(json[:data][:attributes]).to have_key(:name)
    expect(json[:data][:attributes][:name]).to be_a String

    expect(json[:data][:attributes].count).to eq(2)
  end

  it 'can create a merchant' do
    body = { name: 'Silly Sauron' }
    headers = { 'Content-Type' => 'application/json' }

    post '/api/v1/merchants', headers: headers, params: JSON.generate(body)

    expect(response).to be_successful

    expect(Merchant.last.name).to eq(body[:name])
  end
end