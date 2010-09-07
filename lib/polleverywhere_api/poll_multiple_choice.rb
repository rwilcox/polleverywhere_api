require 'poll'

module PollEverywhere
  
class MultipleChoicePoll < Poll

  def vote(keyword)
    puts "sending: " + "interpret.json?response=#{keyword}"
    parse_response( send_request("interpret.json?response=#{keyword}", nil) )
  end
end

end #module PollEverywhere