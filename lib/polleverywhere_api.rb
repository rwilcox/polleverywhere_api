$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'polleverywhere_api/user'
module PolleverywhereApi
  VERSION = '0.0.1'
end