class AddUserColumns < ActiveRecord::Migration
  def up
  	add_column :users, :provider, :string
  	add_column :users, :uid, :string
  	add_column :users, :name, :string
  end

  def down
  end
end
