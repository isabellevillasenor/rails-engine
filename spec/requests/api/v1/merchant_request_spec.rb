require 'rails_helper'

describe 'Merchant API Endpoints' do
  it 'can return an index of all merchants' do
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

  it 'can return data for one merchant' do
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

  it 'can update a merchant' do
    merchant = create(:merchant)
    old_name = merchant.name
    new_name = { name: 'Super Silly Sauron' }

    patch "/api/v1/merchants/#{merchant.id}", params: new_name

    expect(response).to be_successful
    expect(Merchant.last.name).to eq(new_name[:name])
    expect(Merchant.last.name).to_not eq(old_name)
  end

  it 'can delete a merchant' do
    merchant = create(:merchant)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.all.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can return items for a merchant' do
    merchant = create(:merchant)
    item1 = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    item3 = create(:item, merchant: merchant)
    item_ids = [item1.id, item2.id, item3.id]
    
    merchant2 = create(:merchant)
    item4 = create(:item, merchant: merchant2)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    
    response = json[:data].map do |item|
      item[:id].to_i
    end
    
    expect(response).to eq(item_ids)
    expect(response).to_not include(item4.id)
  end
end