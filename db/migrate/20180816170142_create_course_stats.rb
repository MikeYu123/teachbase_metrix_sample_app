class CreateCourseStats < ActiveRecord::Migration[5.1]
  def change
    create_table :course_stats do |t|
      t.integer :score
      t.integer :time_spent
      t.integer :lock_version

      t.timestamps
    end
  end
end
