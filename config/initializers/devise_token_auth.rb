# frozen_string_literal: true

DeviseTokenAuth.setup do |config|
  config.token_lifespan = 2.weeks
  
  config.max_number_of_devices = 10
  
  config.batch_request_buffer_throttle = 10.seconds
  config.change_headers_on_each_request = false
end
