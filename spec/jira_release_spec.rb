require 'spec_helper'

describe JiraRelease do
	before(:all) do
    	jira_domain="https://jira.company.tools/"
  		jira_username="test_user"
  		jira_password="test_password"
  		@jira = JIRAClient.new(jira_username, jira_password, jira_domain)
  	end

  it 'has a version number' do
    expect(JiraRelease::VERSION).not_to be nil
  end

  it 'raises error with missing url' do
    expect{@jira.run("get")}.to raise_error(ArgumentError)
  end

  it 'raises error with missing payload for post request' do
    #expect(true).to eq(true)
    expect{@jira.run("post", "sample/url")}.to raise_error(ArgumentError)
  end

end
