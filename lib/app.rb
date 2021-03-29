class App
  attr_reader :parsed_input
  def start
    loop do
      puts prompt
      input = gets.chomp

      break if input == 'exit'

      @parsed_input = InputParser.new(input).parse

      begin
        case parsed_input&.dig(:cmd)
        when "CREATE EVENT"
          Event.create!(name: parsed_input[:params][:event_name])
          puts 'Event created successfully'

        when "CREATE SPEAKER"
          Speaker.create!(name: parsed_input[:params][:speaker_name])
          puts 'Speaker created successfully'

        when "CREATE TALK"
          Talk.create!(
            event_id: event.id,
            speaker_id: speaker.id,
            name: parsed_input[:params][:talk_name],
            start_time: parse_time(parsed_input[:params][:start_time]),
            end_time: parse_time(parsed_input[:params][:end_time])
          )
          puts 'Talk created successfully'
        end
      rescue ActiveRecord::ActiveRecordError => e
        puts e
      end
    end
  end

  private

  def event
    Event.find_by!(name: parsed_input[:params][:event_name])
  end

  def speaker
    Speaker.find_by!(name: parsed_input[:params][:speaker_name])
  end

  def parse_time(time_str)
    time_str.to_time
  end

  def prompt
    <<~PROMPT
      Please enter one of the following commands:

      create event -e <event_name>
      create speaker -s <speaker_name>
      create talk -e <event_name> -t <talk_name> -st <talk_start_time> -et<talk_end_time> -s <speaker_name>
      print talks -e <event_name>
      exit - to end the programme
    PROMPT
  end
end
