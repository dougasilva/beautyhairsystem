module ActiveRecord
  class Base
    mattr_accessor :shared_connection

    def self.connection
      @@shared_connection || retrieve_connection
    end
  end
end

# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
