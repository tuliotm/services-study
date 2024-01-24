module Users
  module Interactors
    class Search
      include Interactor

      delegate :term, to: :context

      def call
        context.users = search_user
      rescue StandardError => e
        Rails.logger.error(e.message)
        context.fail!(message: e.message)
      end

      private

      def search_user
        search_params = {}
        search_params = "lower(name) LIKE '%#{term.downcase}%'" if term.present?

        User.where(search_params)
      end
    end
  end
end
