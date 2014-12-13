class BiDailyScheduler < HerokuScheduler
  def should_run?
    (Time.now.hour % 12) == hour
  end
end