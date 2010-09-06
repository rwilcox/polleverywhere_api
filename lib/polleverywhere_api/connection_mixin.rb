module PollEverywhere
module ConnectionMixin

  def parse_response(response)
    # TODO: error handling for when this returns something bad
    JSON.parse(response.body)
  end

  def send_request(path, method, our_url=nil)
    str_method = ""
    str_method = ".#{method.to_s}" if method
    our_url ||= "http://www.polleverywhere.com/#{path}#{str_method}"
    #puts "Sending request to #{our_url}" #if self.debug
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
      else throw "response was #{response}"
      end
    end
  end

end
end