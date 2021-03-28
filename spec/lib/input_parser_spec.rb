require_relative '../../lib/input_parser'

RSpec.describe InputParser do
  describe '#parse' do
    context 'with valid command' do
      it 'returns hash of params' do 
        input = "CREATE EVENT a_valid_event"
        parsed_input = InputParser.new(input).parse

        expect(parsed_input[:cmd]).to eq 'CREATE EVENT'
        expect(parsed_input[:params][:event_name]).to eq 'a_valid_event'
      end
    end

    context 'with invalid command' do
      it 'returns false' do
        input = "CREATE EVENT an invalid event"
        parsed_input = InputParser.new(input).parse

        expect(parsed_input).to eq false
      end
    end
  end
end
