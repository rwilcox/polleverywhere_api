require 'cgi'
require 'net/http'
require 'net/https'
require 'json'

require 'poll'

class User
  
  attr_accessor :username
  attr_accessor :password
  attr_accessor :debug

  def polls
    object_graph = parse_response( send_request( "my/polls", :json ) )
    object_graph.collect { |current_object| construct_poll_object_for(current_object) }
  end


  def construct_poll_object_for(current_object)
    parent = nil
    parent = current_object["free_text_poll"]
    parent = current_object["multiple_choice_poll"] unless parent
    parent = current_object["pledge_poll"] unless parent

    # TODO: care what kind of poll we have. Right now I don't. WD-rpw 09-03-2010
    Poll.new( parent["permalink"], parent["results_count"], parent["state"], parent["title"],
        parent["type"] )
  end


private
  def parse_response(response)
    # TODO: error handling for when this returns something bad
    JSON.parse(response.body)
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