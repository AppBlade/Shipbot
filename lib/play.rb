require 'open-uri'

@oauth_token = '7b17d7ec14a8d522445f0634a696b72e2dd434ad'
json = JSON.parse open("https://api.github.com/user/repos?per_page=500&oauth_token=#{@oauth_token}").read
directories = []

def deeper(path, level = 1)
  puts path
  puts level
  if level > 3
    nil
  else
    JSON.parse(open("#{path}?oauth_token=#{@oauth_token}").read).select{|r| r['type'] == 'dir' }.map do |directory|
      [directory['path'], deeper(directory['_links']['self'], level + 1)]
    end
  end
end

json.each do |result|
  deeper("#{result['url']}/contents")
end

aaf8712c7e25ed4754a9f8c0be019272b18c65b5

== User ==

  open('https://api.github.com/user/repos?per_page=500&oauth_token=').read

== Orgs ==

  open('https://api.github.com/user/orgs?per_page=500&oauth_token=').read

  open('https://api.github.com/orgs/AppBlade/repos?per_page=500&oauth_token=').read
