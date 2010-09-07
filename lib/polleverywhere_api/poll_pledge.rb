require 'poll'

module PollEverywhere
  
class PledgePoll < Poll

  def poll_detail_url
    "pledge_polls/#{self.permalink}"
  end

  def keyword
    parse_response( send_request(self.poll_detail_url, :json) )["keyword"]
  end

  # keep API consistency
  def keywords
    [self.keyword]
  end


  # amount should be resilient, aka pass 10.00, $10.00 in and it doesn't care
  def vote(keyword, ammount)
    # TODO: for this vote method and the normal aka free text poll
    # we should abstract away the keyword selection. Because THERE IS ONLY ONE!
    # WD-rpw 09-06-2010
    vote_encoded = CGI.escape(ammount)
    parse_response( send_request("interpret.json?response=#{keyword}+#{vote_encoded}", nil) )
  end

end
end #module PollEverywhere