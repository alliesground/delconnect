class CreateTalks < ActiveRecord::Migration[6.0]
  def change
    create_table :talks do |t|
      t.string :name
      t.timestamp :start_time
      t.timestamp :end_time
    end

    add_reference :talks, :event, foreign_key: true, null: false
    add_reference :talks, :speaker, foreign_key: true, null: false
  end
end
