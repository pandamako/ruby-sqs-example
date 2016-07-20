require 'shoryuken'

class Worker
  include Shoryuken::Worker

  shoryuken_options queue: 'test', auto_delete: true

  def perform(sqs_msg, body)
    puts body
  end
end
