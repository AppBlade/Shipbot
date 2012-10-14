json.array! @build_tasks.where(:state => 'queued').all do |node, build_task|
  node.id build_task.id
  node.provisioning_profile build_task.build_rule.try(:provisioning_profile).try(:mobileprovision).try(:url)
  node.developer_certificate build_task.build_rule.try(:provisioning_profile).try(:developer_certificate).try(:keychain_export).try(:path)
  node.developer_certiticate_passcode build_task.build_rule.try(:provisioning_profile).try(:developer_certificate).try(:keychain_export_passcode)
  node.sha build_task.sha
  node.path build_task.build_rule.native_target.xcode_project.xcode_project_refs.where(:sha => build_task.sha).first.path
  node.repository RepositoryTag.where(:sha => build_task.sha, :name => build_task.name).first.repository.full_name
  node.target build_task.build_rule.native_target.product_name
end
