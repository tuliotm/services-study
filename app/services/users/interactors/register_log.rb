module Users
  module Interactors
    class RegisterLog
      include Interactor

      delegate :user, :term, to: :context

      def call
        Rails.logger.info("[INFO] A new search was made by '#{user}' with term '#{term}'")
      rescue StandardError => e
        Rails.logger.error(e.message)
        context.fail!(message: e.message)
      end
    end
  end
end
