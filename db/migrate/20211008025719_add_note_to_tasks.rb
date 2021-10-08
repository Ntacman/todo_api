class AddNoteToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :note, :text
  end
end
