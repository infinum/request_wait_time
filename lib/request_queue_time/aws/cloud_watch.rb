# frozen_string_literal: true

module RequestQueueTime
  module Aws
    class CloudWatch
      UNIT_SECONDS = 'Seconds'
      DIMENSION_ENVIRONMENT = 'Environment'
      DIMENSION_APPLICATION_NAME = 'Application name'

      def initialize(amzn_trace_id_header)
        @client = ::Aws::CloudWatch::Client.new(
          region: RequestQueueTime.config.aws_region,
          credentials:
        )
        @amzn_trace_id_header = amzn_trace_id_header
      end

      def send_metric
        client.put_metric_data(
          namespace: RequestQueueTime.config.metric_namespace,
          metric_data: [{
            metric_name: RequestQueueTime.config.metric_name,
            dimensions:,
            timestamp: Time.now.to_i,
            value: request_queue_time,
            unit: UNIT_SECONDS
          }]
        )
      end

      private

      attr_reader :client
      attr_reader :amzn_trace_id_header

      def credentials
        ::Aws::Credentials.new(
          RequestQueueTime.config.aws_access_key_id,
          RequestQueueTime.config.aws_secret_access_key
        )
      end

      def dimensions
        [
          { name: DIMENSION_ENVIRONMENT, value: RequestQueueTime.config.metric_environment },
          { name: DIMENSION_APPLICATION_NAME, value: RequestQueueTime.config.metric_app_name }
        ]
      end

      def request_queue_time
        Time.now.to_i - AmznTraceId.new(amzn_trace_id_header).request_start_time
      end
    end
  end
end
