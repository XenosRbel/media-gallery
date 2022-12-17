# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"

# Coverage
unless ENV["SKIP_COVERAGE"]
  require "simplecov"
  require "simplecov-lcov"

  GROUPS = {
    "Contracts" => "app/contracts",
    "Forms" => "app/forms",
    "Datatables" => "app/datatables",
    "Decorators" => "app/decorators",
    "Inputs" => "app/inputs",
    "Model views" => "app/model_views",
    "Presenters" => "app/presenters",
    "Queries" => "app/queries",
    "Repositories" => "app/repositories",
    "Serializers" => "app/serializers",
    "Services" => "app/services",
    "Uploaders" => "app/uploaders",
    "Validators" => "app/validators"
  }.freeze

  EXCLUDED_PATHS = (
    [
      %r{app(/[\w\_]+)+/application_[\w_]+\.rb},
      %r{app(/[\w\_]+)+/base[\w_]*\.rb}
    ] +
    %w[
      config/
      db/
      lib/tasks/deployment
      app/helpers/admin/navigation/
      vendor/
    ]
  ).freeze

  SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
  formatters = [SimpleCov::Formatter::LcovFormatter]
  formatters.push(SimpleCov::Formatter::HTMLFormatter) unless ENV["CI"]

  SimpleCov.start "rails" do
    formatter SimpleCov::Formatter::MultiFormatter.new(formatters)

    minimum_coverage 73

    add_filter(EXCLUDED_PATHS)

    GROUPS.each { |name, dir| add_group(name, dir) }
  end
end

require "spec_helper"
require File.expand_path("../config/environment", __dir__)
require "rspec/rails"
require "factory_bot_rails"
require "pry-rails"
require "api"
require "undercover"
require "timecop/rspec"

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.file_fixture_path = config.fixture_path
  config.use_transactional_fixtures = false

  WebMock.allow_net_connect!(net_http_connect_on_start: true)

  config.around(:example, offline: true) do |example|
    WebMock.disable_net_connect!
    example.run
    WebMock.allow_net_connect!(net_http_connect_on_start: true)
  end

  config.around(:example) do |example|
    Timecop::Rspec.time_machine(sequential: true).run(example)
  end

  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation

    DatabaseCleaner.cleaning do
      FactoryBot.lint
    end
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do |example|
    RequestStore.clear!
    # https://github.com/DatabaseCleaner/database_cleaner/issues/519
    DatabaseCleaner.start unless example.metadata[:skip_db_cleaner]
  end

  config.append_after(:each) do |example|
    DatabaseCleaner.clean unless example.metadata[:skip_db_cleaner]
  end
end
