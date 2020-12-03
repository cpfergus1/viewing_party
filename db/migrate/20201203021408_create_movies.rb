class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :api_id
      t.integer :duration

      t.timestamps
    end
  end
end
