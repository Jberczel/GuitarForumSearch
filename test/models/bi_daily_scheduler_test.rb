require 'test_helper'

class BiDailySchedulerTest < ActiveSupport::TestCase
  def setup
    @hour = Time.now.hour
  end

  test 'should perform task if current hour' do
    assert BiDailyScheduler.new(@hour).should_run?
  end

  test 'performs task at 12 hours from current hour' do
    assert BiDailyScheduler.new(@hour + 12).should_run?
  end

  test 'should not perform task if different hour' do
    refute BiDailyScheduler.new(@hour + 1).should_run?
  end

  test 'should not perform task 16 hours from current hour' do
    refute BiDailyScheduler.new(@hour + 16).should_run?
  end

  test 'should perform scheduled task' do
    block_code = BiDailyScheduler.new(@hour).schedule { 'performed a task' }
    assert_equal 'performed a task', block_code
  end
end