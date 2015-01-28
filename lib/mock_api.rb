class MockApi
  def call(env)
    [
      200,
      {},
      ["I am a mock api"]
    ]
  end
end
