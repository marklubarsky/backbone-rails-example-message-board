class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :title 
      t.string :body 
      t.string :last_posted_by 
      t.datetime :last_posted_at 
      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
