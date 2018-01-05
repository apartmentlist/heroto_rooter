class CreateRooters < ActiveRecord::Migration[5.1]
  def change
    create_table :rooters do |t|
      t.string :app,     null: false
      t.string :channel, null: false
      t.string :emoji,   null: false

      t.timestamps
    end
  end
end
