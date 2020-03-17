class CreatePackages < ActiveRecord::Migration[5.2]
  def change
    create_table :packages do |t|
      t.string :title
      t.integer :price_attendee
      t.integer :price_owner
      t.integer :number_of_days

      t.timestamps
    end
  end
end
