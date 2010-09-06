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


private

  def construct_poll_object_for(current_object)
    parent = nil
    parent = current_object["free_text_poll"]
    parent = current_object["multiple_choice_poll"] unless parent
    parent = current_object["pledge_poll"] unless parent

    # TODO: care what kind of poll we have. Right now I don't. WD-rpw 09-03-2010
    Poll.new( self, parent["permalink"], parent["results_count"], parent["state"], parent["title"],
        parent["type"] )
  end

end

end #Module