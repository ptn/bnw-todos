class AddDoneToLists < ActiveRecord::Migration
  def self.up
    add_column :lists, :done, :boolean, :default => false
  end

  def self.down
    remove_column :lists, :done
  end
end
