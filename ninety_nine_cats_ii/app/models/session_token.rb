# == Schema Information
#
# Table name: session_tokens
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  session_token :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SessionToken < ApplicationRecord
  validates :user_id, :session_token, presence: true
  after_initialize :ensure_session_token

  belongs_to :user
end
