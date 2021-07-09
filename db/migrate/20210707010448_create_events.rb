class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.date :date
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
