# frozen_string_literal: true

require 'aws-sdk-cloudwatch'

require_relative 'request_queue_time/version'
require_relative 'request_queue_time/config'
require_relative 'request_queue_time/aws/amzn_trace_id'
require_relative 'request_queue_time/aws/cloud_watch'
require_relative 'request_queue_time/middleware'

module RequestQueueTime
  def self.config
    @config ||= Config.new
  end

  def self.setup
    yield config
  end
end
