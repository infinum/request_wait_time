# frozen_string_literal: true

require 'aws-sdk-cloudwatch'

require_relative 'request_queue_time/version'
require_relative 'request_queue_time/aws/amzn_trace_id'
require_relative 'request_queue_time/aws/cloud_watch'
require_relative 'request_queue_time/middleware'

module RequestQueueTime
  # CloudWatch metric namespace
  mattr_accessor :metric_namespace
  @@metric_namespace = 'RequestQueueTime'

  # CloudWatch app name
  mattr_accessor :metric_app_name
  @@metric_app_name = 'Application'

  # CloudWatch app environment
  mattr_accessor :metric_environment
  @@metric_environment = 'environment'

  # CloudWatch metric name
  mattr_accessor :metric_name
  @@metric_name = 'request-wait-time'

  # AWS access_key_id
  mattr_accessor :aws_access_key_id
  @@aws_access_key_id = ENV.fetch('AWS_ACCESS_KEY_ID', nil)

  # AWS access_key_id
  mattr_accessor :aws_secret_access_key
  @@aws_secret_access_key = ENV.fetch('AWS_SECRET_ACCESS_KEY', nil)

  mattr_accessor :aws_region
  @@aws_region = ENV.fetch('AWS_REGION')

  def self.setup
    yield self
  end
end
