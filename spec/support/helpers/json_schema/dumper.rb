# frozen_string_literal: true

module JsonSchema
  class Dumper
    def initialize(schema_path)
      @schema_path = JsonMatchers.path_to_schema(schema_path)

      matcher = JsonMatchers::Matcher.new(@schema_path)
      document_store = matcher.__send__(:document_store)

      @iterator = RecursiveIterator.new(document_store)
    end

    def call
      schema_content = JSON.parse(File.read(schema_path)).except(ID_ATTRIBUTE, SCHEMA_ATTRIBUTE)

      iterator.call(schema_content)

      schema_content
    end

    private

    attr_reader :schema_path, :iterator

    ID_ATTRIBUTE = "id"
    SCHEMA_ATTRIBUTE = "$schema"
    REFERENCE_ATTRIBUTE = "$ref"

    private_constant :ID_ATTRIBUTE, :SCHEMA_ATTRIBUTE, :REFERENCE_ATTRIBUTE

    class RecursiveIterator
      def initialize(document_store)
        @document_store = document_store
      end

      def call(data)
        recurse_proc(data)
      end

      private

      def recurse_proc(data)
        JSON.recurse_proc(data, &method(:iterator))
      end

      def iterator(json)
        return unless json.is_a?(Hash) && json.key?(REFERENCE_ATTRIBUTE)

        schema = schema(json)
        return unless schema

        data = schema_data(schema)
        return if data.blank?

        recurse_proc(data)
        json.merge!(data)
      end

      def schema(json)
        schema_id = json.delete(REFERENCE_ATTRIBUTE)
        document_store.lookup_schema(schema_id)
      end

      def schema_data(schema)
        schema.data.except(ID_ATTRIBUTE, SCHEMA_ATTRIBUTE)
      end

      attr_reader :document_store
    end
  end
end
