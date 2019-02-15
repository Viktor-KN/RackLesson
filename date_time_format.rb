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
    @errors = []
    validate!
  end

  def valid?
    errors.empty?
  end

  def result
    if valid?
      time = Time.now
      format.map { |elem| time.strftime(DATE_TIME_TOKENS[elem.to_sym]) }.join('-')
    end
  end

  private

  attr_writer :errors

  def validate!
    return errors << "Required 'format' parameter not defined" if format.nil? || format.empty?

    invalid_tokens = format.reject { |elem| DATE_TIME_TOKENS.key?(elem.to_sym) }.uniq
    errors << "Unknown time format [#{invalid_tokens.join(', ')}]" unless invalid_tokens.empty?
  end
end
