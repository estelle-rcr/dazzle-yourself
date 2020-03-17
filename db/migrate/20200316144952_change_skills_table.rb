class ChangeSkillsTable < ActiveRecord::Migration[5.2]
  def change

    change_table(:skill_setups) do |t|
      t.remove :primary_skill_id
      t.remove :secondary_skill_id

      t.belongs_to :skill, index: true
      t.boolean :primary

    end
  end
end
