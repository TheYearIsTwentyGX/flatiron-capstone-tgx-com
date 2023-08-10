module Error
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from Date::Error, with: :render_invalid_date
      end
    end

    private

    def render_invalid_date
      render json: {error: "Invalid date"}, status: :bad_request
    end
  end
end
