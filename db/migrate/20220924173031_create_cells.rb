class CreateCells < ActiveRecord::Migration[7.0]
  def change
    create_table :cells do |t|
      t.references :grid, null: false, foreign_key: true
      t.integer :position
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
