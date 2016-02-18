module Sorry
	module Api
	  	# The core API Client class, instantiated using
	  	# the access token from your account. All requests stem from
	  	# here.
	  	class Client

		  	# Attributes.
		  	attr_accessor :access_token

			# Initialize the API client.
			def initialize(access_token: nil)
				# Define the API Key, fallback to class config and/or environment variables.
				@access_token = access_token || ENV['SORRY_ACCESS_TOKEN']

				# TODO: Validate that it was able to intialize with an API key.

				# Create an empty array to store the path
				# parts for the recursive request building.
				@path_parts = []
			end

			# Define the CRUD based methods.
			%w(get post put delete).each do |name|
				# Define the method based on it's name.
				define_method "#{name}" do |params: nil|
					# Nest in begin block for ensure to work.
					begin
						# Make the request to the API.
						Sorry::Api::Request.new(builder: self).send("#{name}", params: params)
					ensure
						# Reset the path once the request has
						# been completed ready to have a new one
						# placed together.
						reset_path
					end
				end
			end

			# Path compilation.
			#
			# We use a method chaining on the missing method to build
			# path. so pages().notices().updates() compiles to a string path
			# of /pages/notice/updates which is then used to request the
			# data back from the API.

			# Get the entire path.
			def path
				# Combine the parts into a single string.
				@path_parts.join('/')
			end

			# Use the missing methods to build
			# the path using the method name as the
			# part in the request path.
		    def method_missing(method, *args)
				# To support underscores, we replace them with hyphens when calling the API
				@path_parts << method.to_s.gsub("_", "-").downcase
				# Append any arguments to the path.
				@path_parts << args if args.length > 0
				# Flatter the parts to remove any duplcuates.
				@path_parts.flatten!
				# Return an instance of self
				# so we can chain methods together.
				self
		    end

		    # Reset the path parts once a CRUD
		    # method has been called.
		    def reset_path; @path_parts = []; end

	  	end
	end
end