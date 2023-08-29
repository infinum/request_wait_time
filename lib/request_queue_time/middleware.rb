module RequestQueueTime
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      amzn_trace_id_header = env[RequestQueueTime::Aws::AmznTraceId::HEADER]

      Thread.new { send_metric(amzn_trace_id_header) } if amzn_trace_id_header

      @app.call(env)
    end

    private

    def send_metric(amzn_trace_id_header)
      RequestQueueTime::Aws::CloudWatch.new(amzn_trace_id_header).send_metric
    rescue StandardError
      # Ignored
    end
  end
end
