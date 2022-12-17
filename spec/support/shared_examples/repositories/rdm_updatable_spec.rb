# frozen_string_literal: true

RSpec.shared_examples_for :rdm_updatable do
  let(:record) { build_stubbed(factory_model) }
  let(:attributes) { { what: "ever", address_attributes: {} } }

  describe "#transaction" do
    before { allow(relation).to receive(:transaction).with(isolation: :repeatable_read).and_yield }

    it "set transaction level repeatable_read" do
      repository.transaction { nil }

      expect(relation).to have_received(:transaction).with(isolation: :repeatable_read)
    end
  end

  describe "#find_by_rdm_id" do
    let(:rdm_id) { 1111 }
    let(:result) do
      repository.find_by_rdm_id(rdm_id)
    rescue ActiveRecord::RecordNotFound # rubocop:disable Lint/HandleExceptions
    end

    it "find record by rdm_id" do
      expect { result }.to perform_sql_query(<<-SQL.squish)
        "#{relation.table_name}"."rdm_id" = #{rdm_id}
        LIMIT 1
        FOR UPDATE
      SQL
    end
  end

  describe "#create" do
    before { allow(relation).to receive(:create!).and_return(record) }

    it "creates a new record with given attributes" do
      repository.create(attributes)

      expect(relation).to have_received(:create!).with(attributes)
    end
  end

  describe "#update" do
    before { allow(record).to receive(:update!).with(attributes) }

    it "updates object with given attributes" do
      repository.update(object: record, attributes: attributes)

      expect(record).to have_received(:update!).with(attributes)
    end
  end
end
