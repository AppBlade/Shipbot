class RepositoryBranch < ActiveRecord::Base

  belongs_to :repository

  after_create :fetch_tree

  delegate :full_name, :oauth_token, :to => :repository

  def fetch_tree
    JSON.parse(open("https://api.github.com/repos/#{full_name}/git/trees/#{name}?recursive=1&oauth_token=#{oauth_token}").read)['tree'].each do |result|
      if result['path'].match /\.xcodeproj$/
        # fetch the files needed from within the xcodeproj
        puts result['path']
      end
    end
  end

end
