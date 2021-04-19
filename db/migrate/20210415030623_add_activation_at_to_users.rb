class AddActivationAtToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :activation_at, :datetime
    remove_column :users, :activation_at
  end
end
