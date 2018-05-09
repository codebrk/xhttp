require 'net/http'
require 'json'

###
#
# Make HTTP POST requests
#
###

module Http
  class POST
    def initialize(url, data={}, headers={})
      @uri = URI.parse(url)
      @data = data
      @headers = headers

      @response_headers = {}
      @response_content = nil
      @response_status_message = nil
      @response_status_code = nil
    end

    def status_code
      @response_status_code
    end

    def status_message
      @response_status_message
    end

    def content
      @response_content
    end

    def headers
      @response_headers
    end

    def json
      if @response_headers['content-type'] != 'application/json'
        abort '- Response content is not JSON data'
      end

      JSON.parse(@response_content)
    end

    def request

      @headers['user-agent'] = 'xhttp/0.1.0' if @headers['user-agent'].nil?
      http = Net::HTTP.new(@uri.host, @uri.port)
      req = Net::HTTP::Post.new(@uri.request_uri, @headers)

      unless @data.to_a.empty?
        req.body = @data.to_json
      end

      response = http.request(req)

      @response_status_code = response.code
      @response_status_message = response.message
      @response_content = response.body
      response.each_header do |header|
        @response_headers[header] = response[header]
      end
    end
  end
end