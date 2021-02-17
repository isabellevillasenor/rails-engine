require 'rails_helper'

describe 'Merchant API Endpoints' do
  it 'should return an index of all merchants' do
    create_list(:merchant, 4)

    get '/api/v1/merchants'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    json[:data].each do |merchant|
      expect(merchant[:attributes]).to have_key(:id)
      expect(merchant[:attributes][:id]).to be_an Integer

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a String
    end
  end
end