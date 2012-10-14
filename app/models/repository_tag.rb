class RepositoryTag < ActiveRecord::Base

  delegate :full_name, :oauth_token, :to => :repository

  belongs_to :repository

  def fetch_tree
    JSON.parse(open("https://api.github.com/repos/#{full_name}/git/trees/#{name}?recursive=1&oauth_token=#{oauth_token}").read)['tree'].each do |result|
      if result['path'].match /\/(.+)\.xcodeproj\/project\.pbxproj$/
        plist = Plist.parse_ascii(Base64.decode64(JSON.parse(open("#{result['url']}?oauth_token=#{oauth_token}").read)['content']))
        root_uuid = plist['rootObject']
        root_object = plist['objects'][root_uuid]

        xcode_project = XcodeProject.find_or_create_by_uuid root_uuid
        xcode_project.name = File.basename($1)
        xcode_project.save

        XcodeProjectRef.create :xcode_project_id => xcode_project.id, :sha => sha

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

          native_target.build_rules.each do |build_rule|
            Rails.logger.info "FIRE BUILD TASK FOR #{build_rule}!"
          end

          NativeTargetRef.create :native_target_id => native_target.id, :sha => sha
        end
      end
    end
  end

end
