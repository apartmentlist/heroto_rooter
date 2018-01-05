class ChangeEventNameToResource < ActiveRecord::Migration[5.1]
  def up
    rename_column :events, :name, :resource
    execute <<-SQL
      UPDATE events
      SET resource = regexp_replace(resource, '.*:', '')
    SQL
  end

  def down
    rename_column :events, :resource, :name
    execute <<-SQL
      UPDATE events
      SET name = 'api:' || name
    SQL
  end
end
