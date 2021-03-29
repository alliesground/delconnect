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
          talk = Talk.create!(
            event_id: event.id,
            speaker_id: speaker.id,
            name: parsed_input[:params][:talk_name],
            raw_start_time: parsed_input[:params][:start_time],
            raw_end_time: parsed_input[:params][:end_time]
          )

          puts 'Talk created successfully'

        when "PRINT TALKS"
          event.talks.each do |talk|
            puts <<~TALKS
              #{talk.start_time.strftime("%I:%M%p")} - #{talk.end_time.strftime("%I:%M%p")}
              #{talk.name} presented by #{talk.speaker.name}
            TALKS
          end
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

  def prompt
    <<~PROMPT
      Please enter one of the following commands:

      CREATE EVENT event_name
      CREATE SPEAKER speaker
      CREATE TALK event_name 'Talk name' 00:00am 00:00pm speaker
      PRINT TALKS event_name
      exit - to end the programme
    PROMPT
  end
end
