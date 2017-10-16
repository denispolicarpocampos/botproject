class CreateFaqLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :faq_links do |t|
      t.integer :link_id
      t.integer :faq_id
    end
  end
end
