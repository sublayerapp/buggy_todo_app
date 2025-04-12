class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.boolean :completed

      t.timestamps
    end
  end
end
