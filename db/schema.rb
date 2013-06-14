# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130614202750) do

  create_table "access_keys", :force => true do |t|
    t.string   "token_a",    :limit => 999
    t.string   "token_b",    :limit => 999
    t.string   "service",                   :null => false
    t.string   "type",                      :null => false
    t.string   "owner_type"
    t.integer  "owner_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "build_configurations", :force => true do |t|
    t.string   "name"
    t.string   "uuid"
    t.integer  "native_target_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "build_rules", :force => true do |t|
    t.integer  "native_target_id"
    t.integer  "provisioning_profile_id"
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.integer  "build_configuration_id"
    t.string   "appblade_token",              :limit => 32
    t.string   "appblade_release_track_list"
    t.boolean  "appblade_send_notification",                :default => true, :null => false
  end

  create_table "build_task_results", :force => true do |t|
    t.string   "file"
    t.integer  "build_task_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "build_tasks", :force => true do |t|
    t.integer  "build_rule_id"
    t.string   "sha"
    t.string   "name"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "state",         :default => "queued"
  end

  create_table "developer_certificates", :force => true do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "serial"
    t.string   "organization"
    t.datetime "expires_at"
    t.datetime "issued_at"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "keychain_export"
    t.string   "keychain_export_passcode"
    t.integer  "user_id"
  end

  create_table "native_target_refs", :force => true do |t|
    t.integer  "native_target_id"
    t.string   "sha"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "native_targets", :force => true do |t|
    t.integer  "xcode_project_id"
    t.string   "uuid"
    t.string   "product_name"
    t.string   "product_type"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "default_build_configuration_id"
  end

  create_table "provisioning_profiles", :force => true do |t|
    t.string   "uuid"
    t.string   "name"
    t.datetime "issued_at"
    t.datetime "expires_at"
    t.boolean  "enterprise"
    t.string   "application_identifier"
    t.string   "team_identifier"
    t.string   "application_identifier_prefix"
    t.string   "mobileprovision"
    t.integer  "provisioned_devices_count"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "developer_certificate_id"
    t.integer  "user_id"
  end

  create_table "repositories", :force => true do |t|
    t.string   "full_name"
    t.string   "name"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "github_shared_secret"
    t.integer  "github_webhook_id"
    t.boolean  "github_webhook_confirmed", :default => false, :null => false
    t.integer  "user_id"
  end

  create_table "repository_branches", :force => true do |t|
    t.string   "name"
    t.string   "sha"
    t.integer  "repository_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "repository_tags", :force => true do |t|
    t.string   "name"
    t.string   "sha"
    t.integer  "repository_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "user_sessions", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "email"
  end

  create_table "xcode_project_refs", :force => true do |t|
    t.integer  "xcode_project_id"
    t.string   "sha"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "path"
  end

  create_table "xcode_projects", :force => true do |t|
    t.string   "uuid"
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "repository_id"
  end

end
