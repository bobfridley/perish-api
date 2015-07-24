class AddAttachmentDocumentToPerishables < ActiveRecord::Migration
  def self.up
    change_table :perishables do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :perishables, :document
  end
end
