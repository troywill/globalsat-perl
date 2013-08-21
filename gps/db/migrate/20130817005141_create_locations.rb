class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.datetime :time
      t.decimal :lat
      t.decimal :lon

      t.timestamps
    end
  end
end
