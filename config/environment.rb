# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
TwoHundredTwentyTwo::Application.initialize!

ENV['OAUTH_KEY']     = ''
ENV['OAUTH_SECRET']  = ''
ENV['OAUTH_TOKEN']   = ''
ENV['GITHUB_WEBHOOK_HOST']   = 'https://james.fwd.wf'

