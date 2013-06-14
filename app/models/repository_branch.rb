require 'plist/ascii'

class RepositoryBranch < ActiveRecord::Base

  belongs_to :repository

  after_create :fetch_tree

  delegate :full_name, :oauth_token, :to => :repository

  def fetch_tree
    results = JSON.parse(open("https://api.github.com/repos/#{full_name}/git/trees/#{name}?recursive=1&oauth_token=#{oauth_token}").read)
    results['tree'].each do |result|
      if result['path'].match /\/(.+)\.xcodeproj$/
        plist_result = results['tree'].select{|r| r['path'] == "#{result['path']}/project.pbxproj" }.first
        plist = Plist.parse_ascii(Base64.decode64(JSON.parse(open("#{plist_result['url']}?oauth_token=#{oauth_token}").read)['content']))
        root_uuid = plist['rootObject']
        root_object = plist['objects'][root_uuid]

        xcode_project = repository.xcode_projects.find_or_create_by_uuid root_uuid
        xcode_project.name = File.basename($1)
        xcode_project.save

        XcodeProjectRef.create :xcode_project_id => xcode_project.id, :sha => sha, :path => result['path']

        root_object['targets'].each do |target_uuid|
          target = plist['objects'][target_uuid]
          native_target = xcode_project.native_targets.where(:uuid => target_uuid).first || xcode_project.native_targets.new
          native_target.uuid = target_uuid
          native_target.product_name = target['productName']
          native_target.product_type = target['productType']
          native_target.save

          plist['objects'][target['buildConfigurationList']]['buildConfigurations'].each do |configuration_id|
            config = plist['objects'][configuration_id]
            build_configuration = native_target.build_configurations.where(:uuid => configuration_id).first || native_target.build_configurations.new
            build_configuration.name = config['name']
            build_configuration.uuid = configuration_id
            build_configuration.save
          end

          native_target.default_build_configuration = native_target.build_configurations.where(:name => plist['objects'][target['buildConfigurationList']]['defaultConfigurationName']).first
          native_target.save

          NativeTargetRef.create :native_target_id => native_target.id, :sha => sha
        end
      end
    end
  end

end
