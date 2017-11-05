

module Helpers
    def remove_account(account)
      HTTParty.delete("http://nbooks.herokuapp.com/api/accounts/#{account['email']}")
    end
end