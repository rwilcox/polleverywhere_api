require File.dirname(__FILE__) + '/test_helper.rb'

class TestUser < Test::Unit::TestCase

  def setup
  end
  
  def test_polls
    body =<<EOF
    [{"free_text_poll":{"permalink":"ODk5Nzk3MzIy","title":"What is your name, dude?",
      "type":"FreeTextPoll","owner":{"email":"ryanwilcox@gmail.com"},
      "results_count":1,"state":"opened"}},
      {"multiple_choice_poll":{"permalink":"LTE0MzczMzUzNzc","title":"multiple choice poll",
      "type":"MultipleChoicePoll","owner":{"email":"ryanwilcox@gmail.com"},
      "results_count":0,"state":"opened"}},
      {"pledge_poll":{"permalink":"LTc4MjQ3MDU4","title":"Goal Pole","type":"PledgePoll",
      "owner":{"email":"ryanwilcox@gmail.com"},"results_count":0,"state":"opened"}}]
EOF

    FakeWeb.register_uri(:get, "http://www.polleverywhere.com/my/polls.json",
        :body => body)

    u = User.new
    assert_not_nil u.polls.select{ |poll| poll.title == "What is your name, dude?" }
  end
end
