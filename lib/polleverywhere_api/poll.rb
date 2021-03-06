module PollEverywhere
  
class Poll
  attr_accessor :permalink
  attr_accessor :result_count
  attr_accessor :state
  attr_accessor :title
  attr_accessor :type
  attr_reader :user

  include ConnectionMixin

  def initialize(user, permalink, result_count, state, title, type)
    @user = user
    self.permalink = permalink
    self.result_count = result_count
    self.state = state
    self.title = title
    self.type = type
  end

  def poll_detail_url
    "free_text_polls/#{self.permalink}"
  end


  def keyword
    parse_response( send_request(self.poll_detail_url, :json) )["keyword"]
  end

  # same as keyword, but returns an Array (for API consistency)
  def keywords
    [self.keyword]
  end

  def results
    parse_response( send_request(self.poll_detail_url, :json) )["results"]
  end


  def vote(keyword, vote)
    vote_encoded = CGI.escape(vote)
    parse_response( send_request("interpret.json?response=#{keyword}+#{vote_encoded}", nil) )
  end

  def username
    user.username
  end

  def password
    user.password
  end

private
  def send_detail_request
    
  end
end
end #module PollEverywhere