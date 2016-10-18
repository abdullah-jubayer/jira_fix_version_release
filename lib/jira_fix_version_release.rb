require "jira_fix_version_release/version"
require 'jira_fix_version_release/jira_options'

module JiraFixVersionRelease
  def self.parse(args)
		options = {}
		opt_parser = OptionParser.new do |opts|
			opts.banner = "Usage: jira_fix_version_release [options]"
			opts.separator " "
	      	opts.separator "Specific options:"

	      	opts.on("-h", "--help", "Displays help") do
        		puts opts
        		exit
      		end

	      	opts.on("-u", "--username=USERNAME",
	              "JIRA username is required") do |username|
		        options[:username] = username
		    end

		    opts.on("-p", "--password=PASSWORD",
	              "JIRA password is required") do |password|
		        options[:password] = password
		    end

		    opts.on("-j", "--project_key=PROJECT_KEY",
	              "JIRA project key is required") do |project_key|
		        options[:project_key] = project_key
		    end

		    opts.on("-v", "--fix_version=FIX_VERSION",  
      		      "JIRA fix version is required") do |v|
    			options[:fix_version] = v
  			end

		    opts.on("-f", "--jql_filter=JQL_FILTER",
	              "JQL filter query is required") do |jql_filter|
		        options[:jql_filter] = jql_filter
		    end

		    opts.on("-d", "--jira_domain=JIRA_DOMAIN",  
      		      "JIRA domain is required") do |d|
    			options[:jira_domain] = d
  			end	

		    opts.on("-c", "--commits",
	              "displays commit history") do |commits|
		        options[:commits] = commits
		    end	    

		end.parse!

		if options[:username] == nil
			print 'Enter JIRA username: '
    		options[:username] = gets.chomp
    	end

    	if options[:password] == nil
    		options[:password] = `read -s -p "Enter JIRA password: " password; echo $password`.chomp
    		puts ""
    	end

    	if options[:project_key] == nil
			print 'Enter JIRA project KEY: '
    		options[:project_key] = gets.chomp
    	end

    	if options[:fix_version] == nil
			print 'Enter JIRA fix version: '
    		options[:fix_version] = gets.chomp
    	end

    	if options[:jira_domain] == nil
			print 'Enter JIRA url: '
    		options[:jira_domain] = gets.chomp
    	end

    	if options[:jql_filter] == nil
			print 'Enter JQL filter: '
    		options[:jql_filter] = gets.chomp
    	end

    	return options
	end

	def self.execute_options(options)
		fix_version = options[:fix_version]
		
		jira = JIRAOptions.new(options[:username], options[:password], options[:jira_domain])

		puts "Running script please wait...", ""
		issues = jira.getUnreleasedJiraTickets(options[:project_key], options)

		puts "Discovered ready to release tickets!"

		release = jira.createFixVersion(fix_version)
		puts "Fix version: #{fix_version} created in JIRA"

		issues.each do |issue|
			#puts issue['key']
			jira.updateFixVersion(issue['key'], fix_version)
		end
		puts "Successfully updated Fix Versions!"

		issues.each do |issue|
			if options[:commits] != nil
				puts "Commit History"
				puts jira.getCommitMessages(issue['id'])
				STDOUT.flush
    		end
		end
		jira.releaseFixVersion(release['id'])
	end
end

