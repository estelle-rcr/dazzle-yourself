class CreateSkillSetups < ActiveRecord::Migration[5.2]
  def change
    create_table :skill_setups do |t|
      t.boolean :primary
      t.boolean :secondary
      t.references :user, index: true
      t.references :skill, index: true
      t.timestamps
    end
  end
end
