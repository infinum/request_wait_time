module RequestWaitTime
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      #env[RequestWaitTime::Aws::AmznTraceId::HEADER] = "Self=1-64EC7B26-12456789abcdef012345678;Root=1-#{(Time.current.to_i - rand(0..2)).to_s(16)}-abcdef012345678912345678;CalledFrom=app"

      amzn_trace_id_header = env[RequestWaitTime::Aws::AmznTraceId::HEADER]

      Thread.new { send_metric(amzn_trace_id_header) } if amzn_trace_id_header

      @app.call(env)
    end

    private

    def send_metric(amzn_trace_id_header)
      RequestWaitTime::Aws::CloudWatch.new(amzn_trace_id_header).send_metric
    rescue StandardError
      # Ignored
    end
  end
end
