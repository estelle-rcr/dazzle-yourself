class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    Tag.create :name => "alimentation"
    Tag.create :name => "voyage"
    Tag.create :name => "mode / beauté"
    Tag.create :name => "biens de consommation"
    Tag.create :name => "services B2B"
    Tag.create :name => "associatif / aide"
    Tag.create :name => "sport"
    Tag.create :name => "loisirs"
    Tag.create :name => "éducation"
    Tag.create :name => "environnement"
    Tag.create :name => "logement"
    Tag.create :name => "administration"
    Tag.create :name => "logiciels / IT"
    Tag.create :name => "conseil"
    Tag.create :name => "publicité"
    Tag.create :name => "finance"
    Tag.create :name => "droit"
    Tag.create :name => "mise en relation"
    Tag.create :name => "sécurité"
    end
end
