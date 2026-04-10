class AddAvatarUrlToProfiles < ActiveRecord::Migration[8.1]
  def change
    add_column :profiles, :avatar_url, :string
  end
end