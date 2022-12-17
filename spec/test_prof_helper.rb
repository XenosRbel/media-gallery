# frozen_string_literal: true

require "test-prof"

TestProf::EventProf.configure do |config|
  config.top_count = 15
  config.event = "sql.active_record"
  config.rank_by = :time
end
