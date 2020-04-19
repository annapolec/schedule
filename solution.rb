require 'time'
require_relative 'meeting'
require_relative 'parser'
require_relative 'max_nap_time_calculator'

def solution(s)
  schedule = Parser.parse(s)
  MaxNapTimeCalculator.new(schedule).call
end
