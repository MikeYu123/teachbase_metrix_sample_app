class CreateSectionStats < ActiveRecord::Migration[5.1]
  def change
    create_table :section_stats do |t|
      t.integer :score
      t.integer :time_spent
      t.integer :lock_version


      t.references :course_stat, foreign_key: true
      t.timestamps
    end
  end
end
