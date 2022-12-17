# frozen_string_literal: true

require "json_matchers/rspec"

require "test_prof_helper" if ENV["EVENT_PROF"]

JsonMatchers.schema_root = "spec/support/schemas/json"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  at_exit do
    if ParallelTests.first_process?
      ParallelTests.wait_for_other_processes_to_finish
      FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads/*"])
    end
  end
end
