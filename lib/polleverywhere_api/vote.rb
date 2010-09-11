module PollEverywhere
  
  class Vote

    include ConnectionMixin

    # There are two ways to vote using this API wrapper:
    #  1) Traverse a User object get the Poll from User#polls, then call Poll#vote
    #     This method works if it's YOUR User
    #
    #  2) PollEverywhere::Vote.cast(keyword, value)
    #    This works EXACTLY like the (mobile) website at PollEverywhere (http://poll4.com)
    #    Instructions for polls are either:
    #      "Text 11235 to 22333" 
    #      (in this case: `PollEverywhere::Vote.cast("11235")` )
    #     OR
    #      "Text 314159 and then your first name to 22333"
    #      (in this case: `PollEverywhere::Vote.cast("314159", "Ryan")` )
    #
    def self.cast(keyword, value=nil)
      v = PollEverywhere::Vote.new  # because connection_mixin methods are 
                                    # instance methods. Don't like this hack. WD-rpw 09-11-2010

      encoded_value = ""
      unless value.nil?
        encoded_value = "+#{CGI.escape(value)}"
      end
      v.parse_response( v.send_request("interpret.json?response=#{keyword}#{encoded_value}", nil, nil, false) )
    end
  end
  
end