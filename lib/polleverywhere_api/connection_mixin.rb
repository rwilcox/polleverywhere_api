module PollEverywhere
  
  class LoginException < Exception
  end

  class UnknownException < Exception
  end

module ConnectionMixin

  def parse_response(response)
    begin
      JSON.parse(response.body)
    rescue JSON::ParserError => e
      # ok, something odd happened. Let's run through the possibilities...
      # 1) they didn't log in properly. Look for <a href="/login">
      if response.body =~ /<a href="\/login">/
        raise LoginException
      else
        raise UnknowException, "The following was not valid JSON: #{response.body}"
      end

      # TODO: some other checks here?
    end
  end

  def send_request(path, method, our_url=nil, needs_auth=true)
    str_method = ""
    str_method = ".#{method.to_s}" if method
    our_url ||= "http://www.polleverywhere.com/#{path}#{str_method}"
    #puts "Sending request to #{our_url}" #if self.debug
    url = URI.parse(our_url)
    http_connection = Net::HTTP.new(url.host,url.port)

    req = Net::HTTP::Get.new(url.request_uri)
    #puts "url.(full) path is: #{url.request_uri}"
    http_connection.use_ssl = (our_url =~ /https:/)

    if needs_auth
      req.basic_auth self.username, self.password
    end

    http_connection.start do |http|
      response = http.request(req)
      case response
      when Net::HTTPSuccess then response
      when Net::HTTPRedirection then send_request(path, method, response["location"], needs_auth)
      else throw "response was #{response}"
      end
    end
  end

end
end