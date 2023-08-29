# frozen_string_literal: true

module RequestQueueTime
  module Aws
    class AmznTraceId
      HEADER = 'HTTP_X_AMZN_TRACE_ID'

      def initialize(amzn_trace_id_header)
        @amzn_trace_id_header = amzn_trace_id_header
      end

      attr_reader :amzn_trace_id_header

      def time
        amzn_trace_id_header.split('Root=')[1].split('-')[1].to_i(16)
      end
    end
  end
end
