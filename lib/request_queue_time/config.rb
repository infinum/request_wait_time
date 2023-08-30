# frozen_string_literal: true

module RequestQueueTime
  class Config
    DEFAULT_METRIC_APP_NAME = 'Application'
    DEFAULT_METRIC_ENVIRONMENT = 'Environment'
    DEFAULT_METRIC_NAME = 'request-queue-time'
    DEFAULT_METRIC_NAMESPACE = 'RequestQueueTime'

    attr_accessor :aws_access_key_id
    attr_accessor :aws_secret_access_key
    attr_accessor :aws_region
    attr_accessor :metric_app_name
    attr_accessor :metric_environment
    attr_accessor :metric_name
    attr_accessor :metric_namespace

    def initialize
      self.aws_access_key_id = ENV.fetch('AWS_ACCESS_KEY_ID', nil)
      self.aws_secret_access_key = ENV.fetch('AWS_SECRET_ACCESS_KEY', nil)
      self.aws_region = ENV.fetch('AWS_REGION', nil)
      self.metric_app_name = DEFAULT_METRIC_APP_NAME
      self.metric_environment = DEFAULT_METRIC_ENVIRONMENT
      self.metric_name = DEFAULT_METRIC_NAME
      self.metric_namespace = DEFAULT_METRIC_NAMESPACE
    end
  end
end
