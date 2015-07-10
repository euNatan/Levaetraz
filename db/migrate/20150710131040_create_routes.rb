class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.references :map, index: true
      t.string :origin
      t.string :destination
      t.decimal :distance

      t.timestamps null: false
    end
  end
end
