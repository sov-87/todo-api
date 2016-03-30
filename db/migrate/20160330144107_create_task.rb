class CreateTask < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.references :board
      t.datetime :completed_at

      t.timestamps
    end
  end
end
