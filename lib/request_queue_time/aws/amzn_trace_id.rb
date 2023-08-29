# frozen_string_literal: true

module RequestQueueTime
  module Aws
    class AmznTraceId
      HEADER = 'HTTP_X_AMZN_TRACE_ID'
      FIELD_DELIMITER = ';'
      ROOT_FIELD = 'Root'

      def initialize(header)
        @header = header
      end

      attr_reader :header

      def request_start_time
        root.time.to_i(16)
      end

      def fields
        @fields ||= header.split(FIELD_DELIMITER).map { |field| Field.new(field) }
      end

      def root
        fields.find { |field| field.name == ROOT_FIELD }
      end
    end

    class Field
      FORMAT_DIVIDER = '='
      SEGMENT_DELIMITER = '-'

      attr_reader :name
      attr_reader :version
      attr_reader :time
      attr_reader :id

      def initialize(field)
        @name, segments = field.split(FORMAT_DIVIDER)
        @version, @time, @id = segments.split(SEGMENT_DELIMITER)
      end
    end
  end
end
