require "yaml"

class MockApi
  attr_reader :json_responder,
              :request

  YAML.load(File.read("./lib/config/application.yml")).each do |key, value|
    ENV[key] = value
  end

  def initialize
    @json_responder = JsonResponder.new
  end

  def call(env)
    @request = { env: env }

    json_responder.run(request)

    [
      200,
      { "Content-Type" => "application/json" },
      [ request[:response] ]
    ]
  end
end
