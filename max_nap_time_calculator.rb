class MaxNapTimeCalculator
  def initialize(schedule)
    @schedule = schedule.sort_by { |meeting| [meeting.start_at, meeting.end_at] }
  end

  def call
    (0..schedule.length-2).map do |index|
      time_difference(schedule[index], schedule[index+1])
    end.max.to_i
  end

  private

  attr_reader :schedule

  def time_difference(meeting, next_meeting)
    (next_meeting.start_at - meeting.end_at) / 60
  end
end
