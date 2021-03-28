class InputParser
  attr_reader :input, :current_cmd

  CMD_FORMAT = /^(?<cmd>[A-Z]+ [A-Z]+)/

  EVENT_FORMAT = /(?<event_name>[a-zA-Z]+(_[a-zA-Z]+)+)$/
  SPEAKER_FORMAT = /(?<speaker_name>[a-zA-Z]+)$/
  TIME_FORMAT = /(?<start_time>\d+:\d+[am|pm]{2}) (?<end_time>\d+:\d+[am|pm]{2})/
  TALK_FORMAT = Regexp.new("#{EVENT_FORMAT.source.delete_suffix('$')} #{/(?<talk_name>'.+')/} #{TIME_FORMAT} #{SPEAKER_FORMAT}")

  COMMANDS = [
    "CREATE EVENT",
    "CREATE SPEAKER",
    "CREATE TALK",
    "PRINT TALK",
  ]

  ARG_FORMATS = {
    "CREATE EVENT" => EVENT_FORMAT,
    "CREATE SPEAKER" => SPEAKER_FORMAT,
    "CREATE TALK" => TALK_FORMAT
  }

  def initialize(input)
    @input = input

    @current_cmd = input.match(CMD_FORMAT)&.named_captures&.dig('cmd')
  end


  def parse
    return unless valid_cmd?
    return unless valid_args?

    {
      cmd: current_cmd,
      params: input.match(ARG_FORMATS[current_cmd]).named_captures.transform_keys(&:to_sym)
    }
  end

  private

  def valid_cmd?
    return true if current_cmd && COMMANDS.include?(current_cmd)

    puts "\n INVALID COMMAND"
    false
  end

  def valid_args?
    return true if input.match?(ARG_FORMATS[current_cmd])
    puts "\n INVALID ARGUMENTS"
    return false
  end
end
