require 'net/http'
require 'net/http/post/multipart'
require 'json'
require 'tmpdir' 
require 'fileutils'
require 'zip/zipfilesystem'
require 'base64'

shipbot = Net::HTTP.new('james.fwd.wf', 443)
shipbot.use_ssl = true
shipbot.ca_file = File.join(File.dirname(__FILE__), '../config/cacert.pem')
shipbot.verify_mode = OpenSSL::SSL::VERIFY_PEER

codeload = Net::HTTP.new('codeload.github.com', 443)
codeload.use_ssl = true
codeload.ca_file = File.join(File.dirname(__FILE__), '../config/cacert.pem')
codeload.verify_mode = OpenSSL::SSL::VERIFY_PEER

`security unlock-keychain -p asdf shipbot.keychain`

# Start the connection to ShipBot and Github
shipbot.start {
  codeload.start {

    # Request the pending build tasks
    shipbot.request_get '/build_tasks.json' do |build_tasks_response|
    
      # Parse and iterate
      JSON.parse(build_tasks_response.body).each do |build_task|

        Dir.mktmpdir do |temp_dir|

          zipball = File.open "#{temp_dir}/#{build_task['sha']}.zip", 'w+'

          codeload.request_get URI.parse(build_task['archive_link']).request_uri do |archive_response|
            archive_response.read_body do |archive_response_chunk|
              zipball << archive_response_chunk
            end
          end

          zipball.close
          
          xcode_project = File.basename build_task['path']

          Dir.mkdir "#{temp_dir}/extract"
          `unzip #{zipball.path} -d #{temp_dir}/extract`
          root_directory = Dir.entries("#{temp_dir}/extract").reject{|d| d =~ /^\./}.first

          Dir.chdir "#{temp_dir}/extract/#{root_directory}/#{build_task['path']}/.."

          `xcodebuild -project #{xcode_project} -configuration #{build_task['configuration']} -target #{build_task['target']} CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO`

          Dir.chdir "build/#{build_task['configuration']}-iphoneos"
          Dir.mkdir 'Payload'
          app = Dir.entries('.').select{|e| e =~ /\.app$/}.first
          `mv #{app} Payload/#{app}`
          File.open "Payload/#{app}/embedded.mobileprovision", 'w+' do |embedded_mobileprovision|
            embedded_mobileprovision << Base64.decode64(build_task['provisioning_profile'])
          end

          developer_certificate = OpenSSL::PKCS12.new Base64.decode64(build_task['developer_certificate']), build_task['developer_certificate_passcode']
          developer_certificate_sha = Digest::SHA1.hexdigest(developer_certificate.certificate.to_der).upcase

          File.open('developer_certificate.p12', 'w+') do |p12|
            p12 << Base64.decode64(build_task['developer_certificate'])
          end

          `security import #{Dir.pwd}/developer_certificate.p12 -k shipbot.keychain -P "#{build_task['developer_certificate_passcode']}" -T /usr/bin/codesign`

          `codesign -s #{developer_certificate_sha} Payload/#{app}`
          `zip -r #{build_task['target']}.ipa Payload`
          dsym = Dir.entries('.').select{|e| e =~ /\.app\.dSYM$/}.first
          `zip -r #{build_task['target']}.app.dSYM.zip #{dsym}`

          request = Net::HTTP::Post::Multipart.new "/build_tasks/#{build_task['id']}/build_task_results",
                  'file[0]' => UploadIO.new("#{build_task['target']}.ipa", 'application/octet-stream', "#{build_task['target']}.ipa"),
                  'file[1]' => UploadIO.new("#{build_task['target']}.app.dSYM.zip", 'application/octet-stream', "#{build_task['target']}.app.dSYM.zip")

          shipbot.request request

        end

=begin
        

        http.request request
=end
      end

    end

  }
}
