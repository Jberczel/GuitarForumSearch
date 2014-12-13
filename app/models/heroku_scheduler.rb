class HerokuScheduler
  attr_reader :hour
  
  def initialize(hour=2)
    @hour = hour % 12
  end

  def schedule
    yield if should_run?
  end

  def should_run?
    true
  end
end