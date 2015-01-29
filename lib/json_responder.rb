require "net/http"

class JsonResponder
  attr_reader :json,
              :request,
              :uri

  def cache_json
    dir       = "./lib/json/"
    name      = uri.split("").select { |i| i.match(/(\d|\w)/) }.join
    extension = ".json"
    path      = dir + name + extension
    File.write(path, json)
  end

  def get_json
    Net::HTTP.get(URI(uri))
  end

  def get_and_set_json
    @json = get_json
  end

  def run(request)
    @request = request

    set_uri
    get_and_set_json
    cache_json
    set_response
  end

  def set_response
    request[:response] = json
  end

  def set_uri
    uri        = request[:env]["REQUEST_URI"]
    extra_bits = ENV["TEST_SERVER_IP"] + "/"
    @uri = uri.gsub(extra_bits, "")
  end
end
