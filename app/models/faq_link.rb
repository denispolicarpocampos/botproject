class FaqLink < ActiveRecord::Base
  validates_presence_of :faq_id, :link_id

  belongs_to :faq
  belongs_to :link
end
