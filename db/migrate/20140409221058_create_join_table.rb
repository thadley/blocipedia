class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :wikis, :users do |t|
      # t.index [:wiki_id, :user_id]
      # t.index [:user_id, :wiki_id]
    end
  end
end
