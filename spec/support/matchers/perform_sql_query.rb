# frozen_string_literal: true

RSpec::Matchers.define :perform_sql_query do |sql|
  match(notify_expectation_failures: true) do |block|
    queries = collect_queries { block.call }

    expect(queries).to include(be_include(sql))
  end

  description { "validates SQL query is actually performed" }

  supports_block_expectations

  def collect_queries
    [].tap do |queries|
      subscribe { |query| queries << query }

      yield
    rescue ActiveRecord::RecordNotFound
      next
    ensure
      unsubscribe
    end
  end

  def subscribe
    ActiveSupport::Notifications.subscribe("sql.active_record") do |_name, _start, _finish, _id, payload|
      sql = payload[:sql].squish

      next unless sql.start_with?("WITH", "SELECT", "INSERT", "UPDATE", "DELETE")

      binds = payload[:binds]
      bind_sql_params!(sql, binds) if binds.present?

      yield sql
    end
  end

  def unsubscribe
    ActiveSupport::Notifications.unsubscribe("sql.active_record")
  end

  def bind_sql_params!(sql, binds)
    binds.each.with_index.with_object(sql) do |(bind, index), query|
      param_index = "$#{index + 1}"
      param_value = convert_param_value_to_sql(bind)
      query.sub!(param_index, param_value)
    end
  end

  def convert_param_value_to_sql(bind)
    with_cast_class = ActiveModel::Attribute.const_get(:WithCastValue)

    case bind
    when ActiveRecord::Relation::QueryAttribute
      convert_query_attribute_value_to_sql(bind)
    when with_cast_class
      convert_with_case_value_to_sql(bind)
    end
  end

  def convert_query_attribute_value_to_sql(bind)
    value = bind.value_for_database

    case bind.type
    when ActiveModel::Type::Integer
      value.to_s
    when ActiveModel::Type::String, ActiveModel::Type::Value
      "'#{value}'"
    else
      value.to_s
    end
  end

  def convert_with_case_value_to_sql(bind)
    bind.value_for_database.to_s
  end
end
