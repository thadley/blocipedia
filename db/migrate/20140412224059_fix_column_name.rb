class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :wikis, :private, :is_private
  end
end
