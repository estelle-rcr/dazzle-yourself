class ChangeProjectTables < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :end_date
    remove_column :projects, :attendees_subscribed
  end

  def up
    change_column :projects, :state, :string, default: "draft"
  end

  def down
    change_column :projects, :state, :string, default: nil
  end
end
