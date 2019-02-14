class TimeApp
  TIME_FORMATS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }.freeze

  def self.call(env)
    new.run(env)
  end

  def run(env)
    request = Rack::Request.new(env)
    handle(request)
  end

  private

  def handle(request)
    format = request.params['format'].split(',')
    unknown_format = validate(format)
    return response_with_error("Unknown time format [#{unknown_format.join(', ')}]") unless unknown_format.empty?

    time = Time.now
    response = format.map { |elem| time.strftime(TIME_FORMATS[elem.to_sym]) }.join('-')
    response_with_ok(response)
  end

  def response_with_error(body)
    Rack::Response.new(body, 400, 'Content-Type' => 'text/plain')
  end

  def response_with_ok(body)
    Rack::Response.new(body, 200, 'Content-Type' => 'text/plain')
  end

  def validate(format)
    format.reject { |elem| TIME_FORMATS.key?(elem.to_sym) }.uniq
  end
end
