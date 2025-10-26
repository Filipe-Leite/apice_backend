# frozen_string_literal: true

DeviseTokenAuth.setup do |config|
  config.token_lifespan = 2.weeks
  config.token_cost = Rails.env.test? ? 4 : 10
  config.max_number_of_devices = 10
end
