class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.references :package, index: true
      t.references :owner, index: true
      t.string :title
      t.string :short_description
      t.text :long_description
      t.string :state
      t.datetime :submit_date
      t.datetime :publication_date
      t.datetime :start_date
      t.datetime :end_date
      t.integer :attendees_goal, default: 5
      t.integer :attendees_subscribed, default: 0

      t.timestamps
    end
  end
end
