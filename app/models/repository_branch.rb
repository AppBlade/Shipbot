require 'plist/ascii'

class RepositoryBranch < ActiveRecord::Base

  belongs_to :repository

  after_create :fetch_tree

  delegate :full_name, :oauth_token, :to => :repository

  def fetch_tree
    JSON.parse(open("https://api.github.com/repos/#{full_name}/git/trees/#{name}?recursive=1&oauth_token=#{oauth_token}").read)['tree'].each do |result|
      if result['path'].match /\/(.+)\.xcodeproj\/project\.pbxproj$/
        plist = Plist.parse_ascii(Base64.decode64(JSON.parse(open("#{result['url']}?oauth_token=#{oauth_token}").read)['content']))
        root_uuid = plist['rootObject']
        root_object = plist['objects'][root_uuid]

        xcode_project = XcodeProject.find_or_create_by_uuid root_uuid
        xcode_project.name = File.basename($1)
        xcode_project.save

        root_object['targets'].each do |target_uuid|
          target = plist['objects'][target_uuid]
          native_target = xcode_project.native_targets.where(:uuid => target_uuid).first || xcode_project.native_targets.new
          native_target.uuid = target_uuid
          native_target.product_name = target['productName']
          native_target.product_type = target['productType']
          native_target.save
        end
      end
    end
  end

end
