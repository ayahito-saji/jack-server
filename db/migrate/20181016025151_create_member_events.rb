class CreateMemberEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :member_events do |t|
      t.references :member, foreign_key: true
      t.references :event, foreign_key: true
      t.integer :attendance

      t.timestamps
    end
  end
end
