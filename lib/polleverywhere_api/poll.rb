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

  # right now we assume this is a free text poll, because that's all I need
  # but a multiple choice poll will have an options attribute in the json
  def keywords
    parse_response( send_request("free_text_polls/#{self.permalink}", :json) )["keyword"]
  end

  def vote(vote)
    
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