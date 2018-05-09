require 'xhttp/version'
require 'xhttp/get'
require 'xhttp/post'

module Xhttp
  class Requests
    def get(url, params={}, headers={})
      obj = Http::GET.new(url, params, headers)
      obj.request
      obj
    end

    def post(url, data={}, headers={})
      obj = Http::POST.new(url, data, headers)
      obj.request
      obj
    end
  end
end

# requests = Xhttp::Requests.new
#
# res = requests.post('http://httpbin.org/post', name: 'Jeeva')
# puts res.content