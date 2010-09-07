require 'poll'

module PollEverywhere
  
class MultipleChoicePoll < Poll

  def poll_detail_url
    "multiple_choice_polls/#{self.permalink}"
  end

  # will return an Array of the keywords (aka choices) you have for this poll
  # vote for one by sending that list item into the vote method
  def keywords
    sef.results.collect {|current_object| current_object["keyword"] }
  end


  # returns a list of hashes. The hashes have the following keys:
  # id, value, results_percentage, results_count, keyword, 
  def results
    parse_response( send_request(self.poll_detail_url, :json) )["options"]
  end


  def vote(keyword)
    parse_response( send_request("interpret.json?response=#{keyword}", nil) )
  end
end

end #module PollEverywhere