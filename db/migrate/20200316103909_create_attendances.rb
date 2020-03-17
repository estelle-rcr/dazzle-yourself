class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :project, index: true
      t.references :attendee, index: true
      t.string :stripe_customer_id
      t.string :state
      t.integer :price_attendee

      t.timestamps
    end
  end
end
