module Sorry
	module Api
		# The core requests library, I actually  build and 
		# make the HTTP requests to the API, parse responses etc.
		class Request

	    	# Initialze the request class.
	  		def initialize(builder: nil)
	  			# Include the build class which
	  			# will give us access to the path.
	  			# TODO: Should we instantiate with this? or make this class methods?
	  			@request_builder = builder
	  		end

			# Define the CRUD based methods.
			%w(get post put delete).each do |name|
				# Define the method based on it's name.
				define_method "#{name}" do |params: nil|
					# Try making the request.
					begin
						# Make the request through the REST client.
						response = http_client.send("#{name}") do |request|
							# Build the request with the parameters.
							configure_request(request: request, params: params)
						end

						# Pasrse the response from the request.
						parse_response(response.body)
					# Handle any errors which occurr.
					rescue => e
						# Pass the request off to the error handler.
						handle_error(e)
					end
				end
			end

	    	# Build the request from the
	    	# givden parameters.
			def configure_request(request: nil, params: nil)
				# Set the URL of the request from the compiled path.
				request.url @request_builder.path
				# Marge the parameters into the request.
				request.params.merge!(params) if params
				# Set the request type to JSON.
				request.headers['Content-Type'] = 'application/json'
				# Include the bearer header if one applied as token.
				request.headers['Content-Type']
	  		end

			# Handle/Parse an errors which happen.
			def handle_error(error)
				# Reraise the error for now.
				# TODO: Handler proper errors somehow.
				raise error
			end

			# Parse the reponse.
			def parse_response(response_body)
				# Parse the response body from JSON into Hash.
				# Return the enveloped 'response' element.
				MultiJson.load(response_body, :symbolize_keys => true)[:response]
			end

	  		# Get access to the HTTP client to make the request.
	  		def http_client
				# Configure Faraday as our HTTP client.
				Faraday.new(Sorry::Api::ENDPOINT) do |faraday|
					# Configure the adapter to throw erros
					# based on the HTTP response codes.
					faraday.response :raise_error
					# Log to the command ling.
					faraday.response :logger
					# make requests with Net::HTTP
					faraday.adapter Faraday.default_adapter
					# Set the HTTP oAuth headers.
					faraday.authorization :bearer, @request_builder.access_token if @request_builder.access_token
				end
	  		end

		end
	end
end