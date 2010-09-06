require 'stringio'
require 'test/unit'

require 'rubygems'
require 'fakeweb'
require 'shoulda'

require File.dirname(__FILE__) + '/../lib/polleverywhere_api'

class TestHelper
  def self.neuter_internet
     FakeWeb.allow_net_connect = false
  end
end

