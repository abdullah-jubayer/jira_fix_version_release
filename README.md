# JiraFixVersionRelease

A simple utility to create and release JIRA Versions. Provide your JIRA credential and JQL query for the issues you want to add a fix version to and this utility will create the fix version and release it for you in JIRA. This script assumes your JIRA user have the permission to create a release and update the issues. This script also assumes that the fix version you provide is new and not created in JIRA yet.

## Requirements

- ruby ~> 2.2.2
- bundler ~> 1.11
- rspec ~> 3.0

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jira_fix_version_release'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jira_fix_version_release

Alternate way to install:

Clone the source and cd into the project directory.

Then execute:

    $ bundle install

Then build and install the gem:

    $ rake install

The gem should install the 'jira_fix_version_release' binary.

Just run:

	$ jira_fix_version_release -h 

## Usage

You can run `jira_fix_version_release -h` from the command line any time to see available options. 
Required options include username, password, project_key, jira_domain, jql_filter and fix_version. 
This gem is intended to be executed with one line command however if an required option is missing then this gem will ask for the value of that option to proceed. 

##### JQL Filter
JIRA Query Language(JQL) allows user to build queries to search for jira issues. You can learn more about constructing JQL queries [here](https://confluence.atlassian.com/jirasoftwarecloud/advanced-searching-764478330.html#Advancedsearching-ConstructingJQLqueries)
Please wrap your query in single quotation and replace all spaces with '+'

For example:
`'project=test AND resolution=Done AND "Sub Team”=dev AND (fixVersion NOT in releasedVersions() OR fixVersion is EMPTY OR fixVersion NOT in releasedVersions())&maxResults=100000&startAt=0'`

should be rescripted as

`'project=test+AND+resolution=Done+AND+"Sub Team"=dev+AND+(fixVersion+NOT+in+releasedVersions()+OR+fixVersion+is+EMPTY+OR+fixVersion+NOT+in+releasedVersions())&maxResults=100000&startAt=0'`

Sample command to execute:
$ `jira_fix_version_release -u username@yourcompany.com -p password -j project_key -v fix_version -d https://yourcompanyjiradomain/ -f 'jqlfilter'`

## Tests

    $ rake spec

    Sample output:

    JiraFixVersionRelease
    	first_test
    	second_test
    	and_so_on

    Finished in 0.0038 seconds (files took 0.22473 seconds to load)
	3 examples, 0 failures

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jira_fix_version_release. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

