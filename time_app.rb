require_relative 'date_time_format'

class TimeApp
  def self.call(env)
    request = Rack::Request.new(env)
    new.send :handle, request
  end

  private

  def handle(request)
    format = request.params['format']&.split(',') || []
    formatter = DateTimeFormat.new(format)

    return response_with_error(formatter.errors.join("\n")) unless formatter.valid?

    response_with_ok(formatter.result)
  end

  def response_with_error(body)
    Rack::Response.new(body, 400, 'Content-Type' => 'text/plain')
  end

  def response_with_ok(body)
    Rack::Response.new(body, 200, 'Content-Type' => 'text/plain')
  end
end
