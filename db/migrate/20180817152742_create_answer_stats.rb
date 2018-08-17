class CreateAnswerStats < ActiveRecord::Migration[5.1]
  def change
    create_table :answer_stats do |t|
      t.integer :score
      t.integer :time_spent
      t.references :quiz_stat, foreign_key: true
      t.integer :lock_version

      t.timestamps
    end
  end
end
