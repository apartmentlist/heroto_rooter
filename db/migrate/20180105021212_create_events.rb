class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :app,     null: false
      t.string :name,    null: false
      t.jsonb  :payload, null: false

      t.timestamps
    end
  end
end
