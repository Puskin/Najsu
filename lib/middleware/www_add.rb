class WwwAdd
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    if request.host.starts_with?("*.pl")
      [301, {"Location" => request.url.sub("//*.pl", "//www.*.pl")}, self]
    else
      @app.call(env)
    end
  end

  def each(&block)
  end
end

