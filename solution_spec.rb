require_relative "solution"
require "test/unit"

class SolutionSpec < Test::Unit::TestCase
  TEST_CASES = [
    { input: "", output: 10080 },
    { input: "Mon 9:00-16:00", output: 9120 },
    { input: "Fri 13:00-15:00", output: 6540 },
    { input: "Mon 18:00-15:00\nTue 18:00-20:00\nWed 18:00-20:00\nThu 18:00-20:00\nFri 18:00-20:00\nSat 18:00-20:00\nSun 18:00-24:00", output: 1620 },
    { input: "Mon 00:00-24:00\nSun 15:00-24:00", output: 8100 },
    { input: "Mon 9:00-13:00\nMon 15:00-18:30\nTue 8:15-14:55\nWed 0:45-12:22\nThu 16:20-18:35\nThu 21:45-22:55\nFri 7:55-8:55\nSat 8:00-23:00", output: 1678 },
    { input: "Tue 5:00-23:00\nWed 5:00-23:00\nThu 5:00-23:00\nFri 5:00-23:00\nSat 5:00-23:00\nSun 5:00-23:00", output:  1740 },
    { input: "Tue 5:00-23:00\nWed 5:00-23:00\nThu 5:00-23:00\nMon 5:00-23:00\nFri 5:00-23:00\nSat 5:00-23:00", output: 1500 }
  ]

  def test_simple
    TEST_CASES.each do |test_case|
      assert_equal(solution(test_case[:input]), test_case[:output])
    end
  end
end
