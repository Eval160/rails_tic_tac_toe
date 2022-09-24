class CreateGrids < ActiveRecord::Migration[7.0]
  def change
    create_table :grids do |t|
      t.references :user, null: false, foreign_key: true
      t.references :opponent, null: false
      t.integer :state, default: 0

      t.timestamps
    end
    add_foreign_key :grids, :users, column: :opponent_id

  end
end
