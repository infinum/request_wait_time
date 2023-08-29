# frozen_string_literal: true

require_relative '../../../lib/request_queue_time/aws/amzn_trace_id'

RSpec.describe RequestQueueTime::Aws::AmznTraceId do
  subject(:amzn_trace_id) { described_class.new(header) }

  let(:header) { 'Self=1-64EC7B26-12456789abcdef012345678;Root=1-64EC7B26-abcdef012345678912345678;CalledFrom=app' }

  describe '#time' do
    it 'returns time in seconds' do
      expect(amzn_trace_id.time).to eq 1_693_219_622
    end
  end
end
