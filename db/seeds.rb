# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

root_to_scan = '/Users/james/Apps/SDK'

# Make sure we don't grab sub-projects
project_dirs = []
potential_projects = Dir["#{root_to_scan}/**/*.xcodeproj"].sort_by(&:size)

begin
  project_dirs << potential_projects.first
  potential_projects.reject! do |potential_project|
    potential_project.match /^#{project_dirs.last.gsub(/\.xcodeproj$/, '')}/
  end
end while potential_projects.any?

project_dirs.each do |dir|
  project = Xcodeproj::Project.new dir
  xcode_project = XcodeProject.find_or_create_by_uuid(project.root_object.uuid)
  xcode_project.name = File.basename(dir)
  xcode_project.save
  project.targets.each do |target|
    native_target = xcode_project.native_targets.where(:uuid => target.uuid).first || xcode_project.native_targets.new
    native_target.uuid = target.uuid
    native_target.product_name = target.product_name
    native_target.product_type = target.product_type
    native_target.save
  end
end
