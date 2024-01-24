module Users
  class Search
    def self.call(term: nil)
      search_params = {}
      search_params = "lower(name) LIKE '%#{term.downcase}%'" if term.present?

      User.where(search_params)
    end
  end
end
