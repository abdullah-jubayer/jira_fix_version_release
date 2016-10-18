require 'rubygems'
require 'date'
require 'jira_fix_version_release/jira_client'

module JiraFixVersionRelease
	class JIRAOptions
		def initialize(username, password, jira_domain)
			jira_domain << '/' unless jira_domain.end_with?('/')
			@jira_client = JIRAClient.new(username, password, jira_domain)
			@headers = {:content_type => 'application/json'}
		end

		def updateFixVersion(issue_key, version_name="default")
			url = "rest/api/2/issue/#{issue_key}"
			payload = '{"update": {"fixVersions" : [{"set":[{"name" : "'+ version_name +'"}]}]}}'
			response = @jira_client.run("put", url, @headers, payload)
			data = @jira_client.getResponseBody(response)
			return data
		end

		def getUnreleasedJiraTickets(project_key, options)
			filter = options[:jql_filter]

	    	jira_url = "rest/api/2/search?jql="
			url = jira_url + filter

			response = @jira_client.run("get", url, @headers)
			data = @jira_client.getResponseBody(response)
			return data['issues']
		end

		def createFixVersion(version_name="default", description=Date.today.strftime("%d/%b/%Y"), project_key=nil, released='true', userStartDate=Date.today.strftime("%d/%b/%Y"), userReleaseDate=Date.today.strftime("%d/%b/%Y"))
			url = "rest/api/2/version"
			payload = '{"name": "'+ version_name +'", "description": "'+ description +'", "project": "'+ project_key +'", "released": ' + released + ', "userStartDate": "'+ userStartDate +'" , "userReleaseDate": "'+ userReleaseDate +'"}'
			
			response = @jira_client.run("post", url, @headers, payload)
			data = @jira_client.getResponseBody(response)
			return data
		end

		def releaseFixVersion(fix_version_id, released='true', userStartDate=Date.today.strftime("%d/%b/%Y"), userReleaseDate=Date.today.strftime("%d/%b/%Y"))
			url = "rest/api/2/version/#{fix_version_id}"
			payload = '{"released": ' + released + '}'

			response = @jira_client.run("put", url, @headers, payload)
			data = @jira_client.getResponseBody(response)
			return data
		end

		def getCommitMessages(issue_id)
			url = "rest/dev-status/1.0/issue/detail?issueId=#{issue_id}&applicationType=stash&dataType=repository"
			commit_description = Array.new
			response = @jira_client.run("get", url, @headers)
			data = @jira_client.getResponseBody(response)
			repositories = data['detail'][0]['repositories']

			for i in 0..repositories.length-1
				commits = repositories[i]["commits"]
				repo_name = repositories[i]["name"]
				for j in 0..commits.length-1
					commit_id = commits[j]['id']
					commit_msg = commits[j]['message']
					commit_description.push("Repository: #{repo_name}, Commit id: #{commit_id}, Message: #{commit_msg}")
				end
			end
			return commit_description
		end

		def isUserPasswordValid
			#wip
			url = "rest/api/2/project"
			response = @jira_client.run("get", url, @headers)
			puts response
			data = @jira_client.getResponseHeaders(response)
			return data
		end

	end
end
