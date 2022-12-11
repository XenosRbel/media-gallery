# frozen_string_literal: true

class BaseSerializer
  include JSONAPI::Serializer

  def serializable_hash
    hash = super
    hash.deep_transform_keys! { |key| key.to_s.camelize(:lower).to_sym } if camelize_keys?
    hash
  end
  alias to_hash serializable_hash

  def as_json
    self.class.is_collection?(@resource, @is_collection) ? as_collection_json : as_one_record_json
  end

  def to_json(*_args)
    Oj.dump(serializable_hash)
  end
  alias serialized_json to_json

  private

  attr_reader :params

  def camelize_keys?
    params[:camelize_keys].present?
  end

  def as_collection_json
    to_hash[:data].map { |hash| hash[:attributes] }
  end

  def as_one_record_json
    (to_hash[:data] || {})[:attributes]
  end
end
