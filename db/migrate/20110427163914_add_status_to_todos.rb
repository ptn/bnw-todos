class AddStatusToTodos < ActiveRecord::Migration
  def self.up
    add_column :todos, :done, :boolean, :default => false
  end

  def self.down
    remove_column :todos, :done
  end
end
