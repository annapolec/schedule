class Parser
  OFFSET = {
    'Mon' => 0,
    'Tue' => 1,
    'Wed' => 2,
    'Thu' => 3,
    'Fri' => 4,
    'Sat' => 5,
    'Sun' => 6
  }.freeze
  FIRST_MEETING_ON_MONDAY = "\nMon 0:00-0:00".freeze
  LAST_MEETING_ON_SUNDAY = "\nSun 24:00-24:00".freeze

  def self.parse(input)
    new(input).parse
  end

  def initialize(input)
    @input = input + FIRST_MEETING_ON_MONDAY + LAST_MEETING_ON_SUNDAY
  end

  def parse
    [].tap do |result|
      input.split("\n").reject(&:empty?).each do |meeting|
        result << parsed_meeting(meeting)
      end
    end
  end

  private

  attr_reader :input

  def parsed_meeting(meeting)
    day, hours = meeting.split(" ")
    meeting_times = meeting_times(day, hours)
    Meeting.new(meeting_times[:start_at], meeting_times[:end_at])
  end

  def meeting_times(day, hours)
    date = date_for(day)
    start_at, end_at = hours.split("-")

    { start_at: Time.parse(start_at, date), end_at: Time.parse(end_at, date) }
  end

  def date_for(day)
    Time.now + OFFSET[day]*24*60*60
  end
end
