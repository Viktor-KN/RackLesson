require_relative 'date_time_format'

class TimeApp
  def call(env)
    request = Rack::Request.new(env)
    handle(request)
  end

  private

  def handle(request)
    return response_with_error([]) if request.params['format'].nil?

    format = request.params['format'].split(',')
    formatter = DateTimeFormat.new(format)

    if formatter.valid?
      response_with_ok(formatter.result)
    else
      response_with_error(formatter.errors)
    end
  end

  def response_with_error(errors)
    text = "Unknown time format [#{errors.join(", ")}]"
    Rack::Response.new(text, 400, 'Content-Type' => 'text/plain')
  end

  def response_with_ok(body)
    Rack::Response.new(body, 200, 'Content-Type' => 'text/plain')
  end
end
