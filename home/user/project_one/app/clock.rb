require File.expand_path('../../../config/boot',        __FILE__)
require File.expand_path('../../../config/environment', __FILE__)

require 'clockwork'

include Clockwork

Clockwork.configure do |config|
  config[:logger] = Logger.new('./log/cron.log')
end

handler do |job|
    puts "Running #{job}"
end

every(1.day, 'midnight.job', :at => '00:00') {
  puts "midnight job"
}
