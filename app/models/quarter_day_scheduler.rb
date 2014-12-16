class QuarterDayScheduler < HerokuScheduler
  def should_run?
    (Time.now.hour - hour) % 6 == 0
  end
end