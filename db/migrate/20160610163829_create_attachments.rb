class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :filePath
      t.boolean :solubility

      t.timestamps null: false
    end
  end
end
