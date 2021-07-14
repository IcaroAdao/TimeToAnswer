class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.string :firstname
      t.string :lastname
      t.string :address
      t.string :gender
      t.date :birthdate
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
