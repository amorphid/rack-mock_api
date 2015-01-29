class MockApi
  attr_reader :json_responder,
              :request

  def initialize
    @json_responder = JsonResponder.new
  end

  def call(env)
    @request = { env: env }

    json_responder.run(request)

    [ 200,
      { "Content-Type" => "application/json" },
      [ request[:response] ]
    ]
  end
end
