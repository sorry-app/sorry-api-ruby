require 'spec_helper'

describe Sorry::Api::Request do

	# Placeholder access token.
	let(:access_token) { Faker::Internet.password(128) }

	# Mock the request object.
	let(:request) { Sorry::Api::Request.new(Sorry::Api::Client.new(access_token: access_token)) }

	describe 'error handling' do

		it 'should reraise any errors' do
			# Pass the error handler a new instance of error.
			expect{request.handle_error(StandardError.new)}.to raise_exception(StandardError)
		end

	end

	describe 'response parsing' do

		# Mock the response body to test the parses.
		let(:response_body) { '{"response":{"id": 1, "name": "Some name"}}' }

		it 'should return an response outside of its envelope' do
			# Expect the parses to remove the envelop.
			expect(request.parse_response(response_body)).to eq({:id => 1, :name => "Some name"})
		end

	end

	describe 'the HTTP client' do

		it 'should be a Faraday client' do
			# Ask the instance for the http_client
			expect(request.http_client).to be_a(Faraday::Connection)
		end

		it 'should be configured with the URL for the endpoint' do
			# Ask the instance for the http_client
			expect(request.http_client.url_prefix.to_s).to eq(Sorry::Api::ENDPOINT)
		end

		it 'has the access_token as a bearer header' do
			# Ask the instance for the http_client
			expect(request.http_client.headers).to include({"Authorization"=>"bearer #{access_token}"})
		end

	end

end