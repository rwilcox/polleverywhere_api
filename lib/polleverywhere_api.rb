$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

path_to_code = File.dirname(__FILE__) + "/polleverywhere_api/"
$:.unshift(path_to_code) unless
  $:.include?(path_to_code) || $:.include?(File.expand_path(path_to_code))

require 'gem_dependancies'

require 'polleverywhere_api/user'


module PolleverywhereApi
  VERSION = '0.0.1'
end