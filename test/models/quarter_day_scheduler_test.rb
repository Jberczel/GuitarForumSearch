require 'test_helper'

class QuarterDaySchedulerTest < ActiveSupport::TestCase
  def setup
    @hour = Time.now.hour
  end

  test 'should perform task if current hour' do
    assert QuarterDayScheduler.new(:hour => @hour).should_run?
  end

  test 'performs task 6 hours from current hour' do
    assert QuarterDayScheduler.new(:hour => (@hour + 6)).should_run?
  end

  test 'performs task 18 hours from current hour' do
    assert QuarterDayScheduler.new(:hour => (@hour + 18)).should_run?
  end

  test 'should not perform task if different hour' do
    refute QuarterDayScheduler.new(:hour => (@hour + 3)).should_run?
  end

  test 'should not perform task 16 hours from current hour' do
    refute QuarterDayScheduler.new(:hour => (@hour + 16)).should_run?
  end

  test 'should perform scheduled task' do
    block_code = QuarterDayScheduler.new(:hour => @hour).schedule { 'performed a task' }
    assert_equal 'performed a task', block_code
  end
end
