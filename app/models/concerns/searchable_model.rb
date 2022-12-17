# frozen_string_literal: true

module SearchableModel
  extend ActiveSupport::Concern
  included do
    include Elasticsearch::Model

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Lint/UnusedMethodArgument
    def self.searched_by(*attributes, methods: [], associations: {}, condition: nil)
      # rubocop:enable Metrics/AbcSize
      # rubocop:enable Metrics/CyclomaticComplexity
      # rubocop:enable Metrics/PerceivedComplexity
      # rubocop:enable Lint/UnusedMethodArgument

      after_commit :refresh_index, on: %i[create update], unless: :skip_callbacks
      after_commit :delete_index, on: [:destroy], unless: :skip_callbacks

      analyzer_config = ConfigReader.config_for(:elasticsearch).fetch(:analysis)
      if analyzer_config.present?
        settings analysis: analyzer_config do
          mapping do
            attributes.each do |attribute|
              indexes attribute
            end
          end
        end
      end

      class << self
        def inherited(heir)
          super(heir)
          heir.index_name(index_name)
          refresh_elasticsearch_model_registry(heir) if heir.name == "Front::#{heir.name.demodulize}"
        end

        def refresh_elasticsearch_model_registry(model)
          registry = Elasticsearch::Model::Registry.__instance
          registered_models = registry.instance_variable_get(:@models)

          registered_models.delete_if do |registered_model|
            registered_model.index_name == model.index_name &&
              registered_model.document_type == model.document_type
          end
          registered_models << model

          registry.instance_variable_set(:@models, registered_models)
        end
      end

      define_method :as_indexed_json do |_options = {}|
        as_json(only: attributes, methods: methods, include: associations)
      end

      define_method :refresh_index do
        if persisted?
          update_index
        else
          delete_index
        end
      end

      define_method :update_index do
        try_elasticsearch_document_manipulation(-> { __elasticsearch__.index_document })
      end

      define_method :delete_index do
        try_elasticsearch_document_manipulation(-> { __elasticsearch__.delete_document })
      end

      define_method :try_elasticsearch_document_manipulation do |manipulation_actions|
        manipulation_actions.call
      rescue Elasticsearch::Transport::Transport::Errors::NotFound
        return
      end

      private :try_elasticsearch_document_manipulation
    end

    def self.influence_on_searchable_children(searchable_children)
      after_commit on: %i[create update], unless: :skip_callbacks do
        if previous_changes[:active].present?
          public_send(searchable_children).find_each do |searchable_child|
            active ? searchable_child.refresh_index : searchable_child.delete_index
          end
        end
      end
    end

    def self.search_influenced_by_parent(parent)
      define_method :parent_is_active do
        parent_active = public_send(parent)&.active
        parent_active.nil? ? false : parent_active
      end
    end
  end
end
