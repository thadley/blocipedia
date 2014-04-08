class AddPrivateFlagToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :private, :boolean, :default => 0
  end
end
