require 'cgi'
require 'net/http'
require 'net/https'
require 'json'


module PollEverywhere
# A user object. A user has_many polls
class User
  
  attr_accessor :username
  attr_accessor :password
  attr_accessor :debug

  include ConnectionMixin

  def polls
    object_graph = parse_response( send_request( "my/polls", :json ) )
    object_graph.collect { |current_object| construct_poll_object_for(current_object) }
  end

  def find_poll_by_permalink(permalink)
    #so to avoid trouble, we get all the polls, look through them for the permalink
    # and return the user the object. (I don't think we want the user pulling down
    # polls they don't have access to?)

    self.polls.detect{ |poll| poll.permalink == permalink }
  end

private

  def construct_poll_object_for(current_object)
    parent = nil
    parent = current_object["free_text_poll"]
    parent = current_object["multiple_choice_poll"] unless parent
    parent = current_object["pledge_poll"] unless parent

    res = nil
    if current_object["free_text_poll"]
      res = Poll.new( self, parent["permalink"], parent["results_count"], parent["state"], parent["title"],
          parent["type"] )
    end

    if current_object["multiple_choice_poll"]
      res = MultipleChoicePoll.new(self, parent["permalink"], parent["results_count"],
          parent["state"], parent["title"], parent["type"])
    end

    if current_object["pledge_poll"]
      res = PledgePoll.new(self, parent["permalink"], parent["results_count"],
          parent["state"], parent["title"], parent["type"])
    end

    res
  end

end

end #Module