require 'net/http'
require 'net/http/post/multipart'
require 'json'

http = Net::HTTP.new('james.fwd.wf', 443)
http.use_ssl = true
http.ca_file = File.join(File.dirname(__FILE__), '../config/cacert.pem')
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# Start the connection to ShipBot
http.start {

  # Request the pending build tasks
  http.request_get '/build_tasks.json' do |build_tasks_response|
  
    # Parse and iterate
    JSON.parse(build_tasks_response.body).each do |build_task|

      #build_results_url = URI.parse("#{host}/build_results/#{build_task['id']}")

      puts build_task['id']

      request = Net::HTTP::Post::Multipart.new "/build_tasks/#{build_task['id']}/build_task_results",
                'file[0]' => UploadIO.new(StringIO.new('asdf'), 'application/octet-stream', 'application.ipa'),
                'file[1]' => UploadIO.new(StringIO.new('asdf123'), 'application/octet-stream', 'application.dsym.zip')

      http.request request

    end

  end

}
