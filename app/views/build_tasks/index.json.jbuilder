json.array! @build_tasks.where(:state => 'queued').all do |node, build_task|
  node.id build_task.id
  node.provisioning_profile Base64.encode64(build_task.build_rule.try(:provisioning_profile).try(:mobileprovision).try(:read))
  node.developer_certificate Base64.encode64(build_task.build_rule.try(:provisioning_profile).try(:developer_certificate).try(:keychain_export).try(:read))
  node.developer_certiticate_passcode build_task.build_rule.try(:provisioning_profile).try(:developer_certificate).try(:keychain_export_passcode)
  node.sha build_task.sha
  node.archive_link build_task.archive_link
  node.path build_task.build_rule.native_target.xcode_project.xcode_project_refs.where(:sha => build_task.sha).first.path
  node.repository RepositoryTag.where(:sha => build_task.sha, :name => build_task.name).first.repository.full_name
  node.target build_task.build_rule.native_target.product_name
  node.configuration build_task.build_rule.build_configuration.name
end
