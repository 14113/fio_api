module FioAPI
    class InvalidJsonResponse < StandardError
        def initialize(message = "Invalid JSON response")
            super(message)
        end
    end
end