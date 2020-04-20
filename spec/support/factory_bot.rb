RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation

    begin
      DatabaseCleaner.start
      FactoryBot.lint strategy: :build unless config.files_to_run.one?
    ensure
      DatabaseCleaner.clean
    end
  end
end