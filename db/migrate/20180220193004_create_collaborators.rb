class CreateCollaborators < ActiveRecord::Migration[5.1]
  def change
    create_table :collaborators do |t|
      t.integer :user_id, foreign_key: true
      t.integer :wiki_id, foreign_key: true

      t.timestamps
    end
  end
end
