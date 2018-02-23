class OverrideDeviseParams
  def initialize(app, options)
    @app = app
    @options = options
  end

  def call(env)
    request = Rack::Request.new(env)
    rack_input = env["rack.input"].read
    req = {}
    req["user"] = JSON.parse(rack_input)
    env["rack.input"] = StringIO.new(req.to_query)
    @app.call(env)
  end

end