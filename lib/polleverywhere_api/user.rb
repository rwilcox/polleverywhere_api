require 'cgi'
require 'net/http'
require 'net/https'

class User
  
  attr_accessor :username
  attr_accessor :password
  attr_accessor :debug

  def polls
    parse_response( send_request( "my/polls", :json ) )
  end
  
private
  def parse_response(response)
    puts response.body
  end

  def send_request(path, method, our_url=nil)
    our_url ||= "https://www.polleverywhere.com/#{path}.#{method.to_s}"
    puts "Sending request to #{our_url}" if self.debug
    url = URI.parse(our_url)
    http_connection = Net::HTTP.new(url.host,url.port)

    req = Net::HTTP::Get.new(url.path)
    http_connection.use_ssl = (our_url =~ /https:/)
    req.basic_auth self.username, self.password

    http_connection.start do |http|
      response = http.request(req)
      case response
      when Net::HTTPSuccess then response
      when Net::HTTPRedirection then send_request(path, method, response["location"])
      end
    end
  end
end