class Addsubject < ActiveRecord::Migration
  def change
    add_column :attachments, :subject, :string
  end
end
