class HerokuScheduler
  attr_reader :hour

  def initialize(args={})
    @hour = args.fetch(:hour,2) % 12
  end

  def schedule
    yield if should_run?
  end

  def should_run?
    true
  end
end
