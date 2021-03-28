class InputParser
  attr_reader :input

  CMD_FORMAT = /^(?<cmd>[A-Z]+ [A-Z]+)/
  EVENT_FORMAT = /(?<event_name>[a-zA-Z]+(_[a-zA-Z]+)+)$/
  SPEAKER_FORMAT = /(?<speaker_name>[a-zA-Z]+)$/
  TIME_FORMAT = /(?<start_time>\d+:\d+[am|pm]{2}) (?<end_time>\d+:\d+[am|pm]{2})/
  TALK_FORMAT = Regexp.new("#{EVENT_FORMAT.source.delete_suffix('$')} #{/(?<talk_name>'.+')/} #{TIME_FORMAT} #{SPEAKER_FORMAT}")

  def initialize(input)
    @input = input
  end


  def parse
    cmd = input.match(CMD_FORMAT)&.named_captures&.dig('cmd')

    case cmd
    when 'CREATE EVENT'
      return unless valid?(EVENT_FORMAT)

      {
        cmd: cmd,
        params: {event_name: input.match(EVENT_FORMAT)[:event_name]}
      }

    when 'CREATE SPEAKER'
      return unless valid?(SPEAKER_FORMAT)

      {
        cmd: cmd,
        params: {speaker_name: input.match(SPEAKER_FORMAT)[:speaker_name]}
      }

    when 'CREATE TALK'
      return unless valid?(TALK_FORMAT)

      input.match(TALK_FORMAT) do |m|
        {
          cmd: cmd,
          params: {
            event_name: m[:event_name],
            talk_name: m[:talk_name],
            start_time: m[:start_time],
            end_time: m[:end_time],
            speaker_name: m[:speaker_name]
          }
        } 
      end
    else
      puts "\n **INVALID COMMAND**"
    end
  end

  private

  def valid?(format)
    unless input.match?(format)
      puts "\n **INVALID ARGUMENTS**"
      return false
    end

    true
  end
end
