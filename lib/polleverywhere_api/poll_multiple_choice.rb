require 'poll'

module PollEverywhere
  
class MultipleChoicePoll < Poll

  def vote(keyword)
    puts "sending: " + "interpret.json?response=#{keyword}"
    response= send_request("interpret.json?response=#{keyword}", nil)
    puts response #.body
  end
end

end #module PollEverywhere