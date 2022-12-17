# frozen_string_literal: true

RSpec.shared_examples_for :time_interval_repository_finder do
  let(:time_format) { "%Y-%m-%d %H:%M:%S.%6N" }
  let(:start_time) { Time.now.utc }
  let(:formatted_start_time) { start_time.strftime(time_format) }
  let(:end_time) { start_time + 5.minutes }
  let(:formatted_end_time) { end_time.strftime(time_format) }

  describe "#find_created_between" do
    let(:result) { repository.find_created_between(start_time, end_time) }

    it "selects new records within time interval" do
      expected_sql = <<~SQL.squish
        "updated_at" BETWEEN '#{formatted_start_time}' AND '#{formatted_end_time}'
        AND (updated_at = created_at)
      SQL

      expect(result.to_sql).to include(expected_sql)
    end
  end

  describe "#find_updated_between" do
    let(:result) { repository.find_updated_between(start_time, end_time) }

    it "selects updated records within time interval" do
      expected_sql = <<~SQL.squish
        "updated_at" BETWEEN '#{formatted_start_time}' AND '#{formatted_end_time}'
        AND (updated_at != created_at)
      SQL

      expect(result.to_sql).to include(expected_sql)
    end
  end
end
