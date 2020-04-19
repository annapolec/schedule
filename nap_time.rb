require 'time'
require 'pry'

# s="Mon 9:00-15:00\nMon 18:00-20:00"

def solution
  s="Mon 18:00-15:00\nMon 18:00-20:00\nTue 18:00-20:00\nWed 18:00-20:00"

  schedule = Parser.parse(s)
  MaxNapTimeCalculator.new(schedule).call
end

class Meeting
  attr_reader :start_at, :end_at

  def initialize(start_at, end_at)
    @start_at = start_at
    @end_at = end_at
  end
end


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
  LAST_MEETING_ON_FRIDAY = "\nFri 24:00-24:00".freeze

  def self.parse(input)
    new(input).parse
  end

  def initialize(input)
    @input = input + FIRST_MEETING_ON_MONDAY + LAST_MEETING_ON_FRIDAY
  end

  def parse
    [].tap do |result|
      input.split("\n").each do |meeting|
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


class MaxNapTimeCalculator
  def initialize(schedule)
    @schedule = schedule.sort_by(&:start_at)
  end

  def call
    (0..schedule.length-2).map do |index|
      time_difference(schedule[index], schedule[index+1])
    end.max.to_i
  end

  private

  attr_reader :schedule

  def time_difference(meeting, next_meeting)
    (next_meeting.start_at - meeting.end_at) / 3600
  end
end
