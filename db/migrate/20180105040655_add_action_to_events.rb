class AddActionToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :action, :string, null: false
  end
end
