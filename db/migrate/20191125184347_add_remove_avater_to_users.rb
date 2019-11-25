class AddRemoveAvaterToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :remove_avatar, :boolean,default: false
  end
end
