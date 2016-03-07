class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.integer :frame, nullable: false
      t.string :first, nullable: false
      t.string :second, default: nil
      t.integer :score
      t.boolean :split, default: false
      t.belongs_to :game, index: true
      t.timestamps null: false
    end
  end
end
