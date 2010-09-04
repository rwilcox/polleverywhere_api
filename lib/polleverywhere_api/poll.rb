class Poll
  attr_accessor :permalink
  attr_accessor :result_count
  attr_accessor :state
  attr_accessor :title
  attr_accessor :type

  def initialize(permalink, result_count, state, title, type)
    self.permalink = permalink
    self.result_count = result_count
    self.state = state
    self.title = title
    self.type = type
  end

  def vote(vote)
    
  end

end