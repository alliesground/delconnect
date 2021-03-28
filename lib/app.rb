class App
  def start
    loop do
      puts prompt
      input = gets.chomp

      break if input == 'exit'

      parsed_input = InputParser.new(input).parse

      begin
        case parsed_input&.dig(:cmd)
        when "CREATE EVENT"
          Event.create!(name: parsed_input[:params][:event_name])
          puts 'Event created successfully'

        when "CREATE SPEAKER"
          Speaker.create!(name: parsed_input[:params][:speaker_name])

          puts 'Speaker created successfully'
        end
      rescue ActiveRecord::RecordInvalid => e
        puts e
      end
    end
  end

  private

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
