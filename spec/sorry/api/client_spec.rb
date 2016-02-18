require 'spec_helper'

describe Sorry::Api::Client do

	let(:access_token) { Faker::Internet.password(128) }

	describe 'attributes' do

		it 'has no access token by default' do
			# Instantiate the class.
			client = Sorry::Api::Client.new
			# Expect the client to have no access token.
			expect(client.access_token).to be_nil
		end

		it 'sets the access token on instantiation' do
			# Instantiate the class.
			client = Sorry::Api::Client.new(access_token: access_token)
			# Expect the client to have no access token.
			expect(client.access_token).to eq(access_token)
		end

		it 'sets an API key from the SORRY_ACCESS_TOKEN ENV variable' do
			# Set the placeholder ENV variable.
			ENV['SORRY_ACCESS_TOKEN'] = access_token
			# Instantiate the class.
			client = Sorry::Api::Client.new
			# Check that the correct token was set.
			expect(client.access_token).to eq(access_token)
		end

		it 'sets the API key from the setter' do
			# Instantiate the class.
			client = Sorry::Api::Client.new
			# Set the access token manually.
			client.access_token = access_token
			# Assert that the token is corrcetly set.
			expect(client.access_token).to eq(access_token)
		end

	end

end