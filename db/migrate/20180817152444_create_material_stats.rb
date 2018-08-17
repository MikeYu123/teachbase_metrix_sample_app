class CreateMaterialStats < ActiveRecord::Migration[5.1]
  def change
    create_table :material_stats do |t|
      t.integer :time_spent
      t.references :section_stat, foreign_key: true
      t.integer :lock_version

      t.timestamps
    end
  end
end
