class AddMessageToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :message, :text
  end
end
