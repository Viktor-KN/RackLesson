class DateTimeFormat
  DATE_TIME_TOKENS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }.freeze

  attr_reader :format, :errors

  def initialize(format)
    @format = format
    validate!
  end

  def valid?
    errors.empty?
  end

  def result
    return unless valid?

    time = Time.now
    format.map { |elem| time.strftime(DATE_TIME_TOKENS[elem.to_sym]) }.join('-')
  end

  private

  attr_writer :errors

  def validate!
    self.errors = format.reject { |elem| DATE_TIME_TOKENS.key?(elem.to_sym) }.uniq
  end
end
