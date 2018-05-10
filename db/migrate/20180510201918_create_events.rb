class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.string :address
      t.datetime :datetime

      t.timestamps
    end
  end
end
