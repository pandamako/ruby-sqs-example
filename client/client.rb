require 'aws-sdk'
require 'yaml'
require 'awesome_print'

class Time
  def to_ms
    (self.to_f * 1000.0).to_i
  end
end

credentials = YAML.load File.read('credentials.yml')
ap credentials
sqs = Aws::SQS::Client.new(
  region: credentials['region'],
  credentials: Aws::Credentials.new(
    credentials['access_key_id'],
    credentials['secret_access_key']
  )
)

def message i
  {
    version: 1,
    advert_id: i,
    campaign_id: 100,
    ad_info: 'full AD',
    ushel_tuda: 'http://google.com/'
  }
end

1000.times do |i|
  start = Time.now
  sqs.send_message(
    queue_url: credentials['url'],
    message_body: message(i).to_json
  )
  ap "#{i} time: #{Time.now.to_ms - start.to_ms}"
end
