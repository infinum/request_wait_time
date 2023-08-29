module RequestWaitTime
  module Aws
    class CloudWatch
      def initialize(amzn_trace_id_header)
        @client = ::Aws::CloudWatch::Client.new(region: 'eu-west-1', credentials: credentials)
        @amzn_trace_id_header = amzn_trace_id_header
      end

      def send_metric
        client.put_metric_data(
          namespace: RequestWaitTime.metric_namespace,
          metric_data: [{
                          metric_name: RequestWaitTime.metric_name,
                          dimensions: dimensions,
                          timestamp: Time.current.to_i,
                          value: request_wait_time,
                          unit: "Seconds"
                        }]
        )
      end

      private

      attr_reader :client, :amzn_trace_id_header

      def credentials
        ::Aws::Credentials.new(RequestWaitTime.aws_access_key_id, RequestWaitTime.aws_secret_access_key)
      end

      def dimensions
        [
          { name: "Environment", value: RequestWaitTime.metric_environment },
          { name: 'Application name', value: RequestWaitTime.metric_app_name }
        ]
      end

      def request_wait_time
        load_balancer_request_start_time = AmznTraceId.new(amzn_trace_id_header).time
        current_time = Time.current.to_i

        current_time - load_balancer_request_start_time
      end
    end
  end
end
