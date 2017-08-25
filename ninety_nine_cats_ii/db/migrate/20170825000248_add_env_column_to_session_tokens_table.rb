class AddEnvColumnToSessionTokensTable < ActiveRecord::Migration[5.1]
  def change
    add_column :session_tokens, :device_info, :string
  end
end
