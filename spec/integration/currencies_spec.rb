require 'swagger_helper'

describe 'Currencies API' do
  let!(:currencies) do
    [
      Currency.create(iso: 'USD', name: 'United States Dollar', rate: 1.0 ),
      Currency.create(iso: 'RUB', name: 'Russian Ruble', rate: 60.200002 ),
      Currency.create(iso: 'AMD', name: 'Armenian Dram', rate: 409.437002 ),
      Currency.create(iso: 'CNY', name: 'Chinese Yuan', rate: 7.116 )
    ]
  end

  let(:parsed_response) { JSON.parse(response.body, symbolize_names: true) }

  before { stub_const('::AUTH_TOKEN', 'currency_exchanger_auth_token')}

  path '/api/v1/currencies' do
    get 'return currencies list' do
      parameter name: :Authorization, in: :header, required: true,
        schema: { type: :string }, description: 'Bearer Token'

      parameter name: :page, in: :query, required: false, schema: { type: :integer}, description: 'Page number'

      response '200', 'successful' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              iso: { type: :string, description: 'Currency ISO Code'},
              name: { type: :string, description: 'Currency name'},
              rate: { type: :string, description: 'Currency rate'}
            },
            required: %i[iso name rate]
          }
            
        let(:Authorization) { 'Bearer currency_exchanger_auth_token' }
        let(:expected_response) do 
          [
            { iso: 'AMD', name: 'Armenian Dram', rate: '409.437002' },
            { iso: 'CNY', name: 'Chinese Yuan', rate: '7.116' },
            { iso: 'RUB', name: 'Russian Ruble', rate: '60.200002' },
            { iso: 'USD', name: 'United States Dollar', rate: '1.0' },
          ]
        end

        run_test! do
          expect(parsed_response).to eq(expected_response)
        end
      end

      response '403', 'Auth token invalid' do
        schema type: :object, properties: { error: { type: :string} }
        
        let(:Authorization) { 'Bearer invalid_token' }

        let(:expected_response) do
          {
            error: 'Auth token invalid'
          }
        end

        run_test! do
          expect(parsed_response).to eq(expected_response)
        end
      end
    end
  end


  path '/api/v1/currencies/{iso}' do
    get 'return currency details' do
      parameter name: :Authorization, in: :header, required: true,
        schema: { type: :string }, description: 'Bearer TOKEN'
      parameter name: :iso, in: :path, required: true,
        schema: { type: :string }, description: 'Currency ISO code'

      response '200', 'successful request' do
        schema type: :object,
          properties: {
            iso: { type: :string, description: 'Currency ISO code' },
            name: { type: :string, description: 'Currency name' },
            rate: { type: :string, description: 'Currency rate' }
          },
          required: %i[iso name rate]

        let(:Authorization) { 'Bearer currency_exchanger_auth_token' }
        let(:iso) { 'rub' }
        let(:expected_response) do
          {
            iso: 'RUB',
            name: 'Russian Ruble',
            rate: '60.200002'
          }
        end

        run_test! do
          expect(parsed_response).to eq(expected_response)
        end
      end
    end
  end
end
