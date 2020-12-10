class RemoveStartTimeFromViewings < ActiveRecord::Migration[5.2]
  def change
    remove_column :viewings, :start_time
  end
end
