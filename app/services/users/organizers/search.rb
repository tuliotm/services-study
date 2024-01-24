module Users
  module Organizers
    class Search
      include Interactor::Organizer

      organize(
        Users::Interactors::Search,
        Users::Interactors::RegisterLog,
      )
    end
  end
end
