class ChangeSkillSetup < ActiveRecord::Migration[5.2]
  def change

    change_table(:skill_setups) do |t|
      t.remove :skill_id
      t.remove :secondary
      t.remove :primary

      t.belongs_to :primary_skill, index: true
      t.references :secondary_skill, index: true

    end

  end

end
