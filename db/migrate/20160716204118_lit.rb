class Lit < ActiveRecord::Migration
  def change
    add_column :attachments, :question1, :boolean
    add_column :attachments, :question2, :boolean
    add_column :attachments, :question3, :boolean
  end
end
