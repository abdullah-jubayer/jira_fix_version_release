require 'rubygems'
require 'rest_client'
require 'json'

class JIRAClient

	def initialize(username, password, jira_domain)
		@username = username
		@password = password
		@jira_domain = jira_domain
	end

	def run(method=nil, url=nil, headers=nil, payload=nil, username=@username, password=@password)
		raise ArgumentError, "Missing required parameters" if (method==nil or url==nil or username==nil or password==nil)
		raise ArgumentError, "Payload required for post/put request" if ((method=="post" or method=="put") and payload==nil)

		options = Hash.new
		options[:method] = method.to_sym
		options[:url] = @jira_domain + url
		options[:user] = username
		options[:password] = password 
		options[:headers] = headers if headers != nil 
		options[:payload] = payload if payload !=nil and method != "get"
		response = RestClient::Request.execute(options)
		if(response.code < 200 or response.code > 299)
		  	raise "Error with the http request!"
		end
		
		return response
	end

	def getResponseBody(response)
		begin
			data = JSON.parse(response.body)
		rescue
			data = nil
		end
		return data
	end

	def getResponseHeaders(response)
		begin
			data = JSON.parse(response.headers)
		rescue
			data = nil
		end
		return data
	end
end