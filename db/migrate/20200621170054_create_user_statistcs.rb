class CreateUserStatistcs < ActiveRecord::Migration[5.2]
  def change
    create_table :user_statistcs do |t|
      t.references :user, foreign_key: true
      t.integer :right_questions, default: 0
      t.integer :wrong_questions, default: 0

      t.timestamps
    end
  end
end
