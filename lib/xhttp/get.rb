require 'net/http'
require 'json'

###
#
# Make HTTP GET requests
#
###

module Http
  class GET
    def initialize(url, params={}, headers={})
      @uri = URI(url)
      @params = params
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
      req = Net::HTTP::Get.new(@uri)
      req['user-agent'] = 'xhttp/0.1.0'

      ###
      #
      # Set request headers
      #
      ###
      @headers.map do |header|
        req[header[0].to_s.downcase] = header[1]
      end

      response = Net::HTTP.start(@uri.hostname, @uri.port) do |http|
        http.request(req)
      end

      @response_status_code = response.code
      @response_status_message = response.message
      @response_content = response.body
      response.each_header do |header|
        @response_headers[header] = response[header]
      end
    end
  end
end