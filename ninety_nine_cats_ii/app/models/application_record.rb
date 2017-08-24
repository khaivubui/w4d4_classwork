class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
