require File.dirname(__FILE__) + '/test_helper.rb'

class TestPoll < Test::Unit::TestCase
 
 context "free text polls" do
   setup do
     body =<<END

{"type":"free_text_poll","web_enabled":false,"mobile_site":"http://poll4.com",
  "results":[{"value":"Dirk Gently","created_at":"about 16 hours ago","id":7126770}],
  "direct_enabled":true,"moderation_enabled":false,"session_keyword":null,
  "shortcode":"22333","sms_enabled":true,"show_branding":false,"keyword":"104548",
  "title":"What is your name?",
  "flash_options":{"headerScale":0.65,
      "IsDefault":{"headerScale":false,"IsDefault":true,"headerLogoUrl":false,
        "bgImageOpacity":false,"messageBGColor":false,"rememberToken":false,
        "headerBGColorTop":false,"headerTitleColor":false,"showInstructions":false,
        "showTimestamps":false,"messageScale":false,"loopMessages":false,
        "headerInstructionColor":false,"headerLogoPlacement":false,
        "messageShowShadow":false,"fancyThemeEffect":false,"bgPrimaryTextColor":false,
        "bgImageUrl":false,"bgColor":false,"bgImagePlacement":false,
        "bgSecondaryTextColor":false,"headerInstructionScale":false,"showTitle":false,
        "headerBGColorBottom":false,"showLogo":false,"pollTheme":false,
    "animationRotateSpeed":false},
    "bgImageOpacity":1.0,"headerLogoUrl":"","rememberToken":"","messageBGColor":16185078,
    "showTimestamps":true,"showInstructions":true,"headerTitleColor":16777215,
    "headerBGColorTop":17289,"loopMessages":false,"messageScale":0.65,"fancyThemeEffect":"EffectFallAndGlow",
    "messageShowShadow":true,"headerLogoPlacement":"left","headerInstructionColor":0,
    "bgImageUrl":"","bgPrimaryTextColor":7525,"bgImagePlacement":"centered","bgColor":16777215,
    "showTitle":true,"headerInstructionScale":1.0,"bgSecondaryTextColor":6710886,
    "animationRotateSpeed":0.5,"pollTheme":"standardTheme","showLogo":true,
    "headerBGColorBottom":7525},
  "twitter_enabled":true,"twitter_keyword":"@poll","question":"What is your name?",
  "state":"opened","participation_verb":"participate",
  "permalink":"ODk5Nzk3MzIy"}
END
     FakeWeb.register_uri(:get, "http://www.polleverywhere.com/free_text_polls/ODk5Nzk3MzIy",
         :body => body)
   end

   should "be able to get keywords from a poll" do
     u = User.new
     u.username = "ryan@example.com"
     u.password = "password"
     poll = Poll.new(u, "ODk5Nzk3MzIy", nil, nil, nil, "free_text_poll")
     res = poll.results[0]

     assert_equal( "about 16 hours ago", res["created_at"] )
     assert_equal( 7126770, res["id"] )
     assert_equal( "Dirk Gently", res["value"] )
   end
 end
 
  def setup
  end

  def test_keywords
    
  end

end
