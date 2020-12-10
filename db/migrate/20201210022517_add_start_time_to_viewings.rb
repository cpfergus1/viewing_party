class AddStartTimeToViewings < ActiveRecord::Migration[5.2]
  def change
    add_column :viewings, :start_time, :datetime
  end
end
