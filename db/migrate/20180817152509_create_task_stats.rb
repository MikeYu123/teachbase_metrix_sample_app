class CreateTaskStats < ActiveRecord::Migration[5.1]
  def change
    create_table :task_stats do |t|
      t.integer :score
      t.references :section_stat, foreign_key: true
      t.integer :lock_version

      t.timestamps
    end
  end
end
