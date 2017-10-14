class Link < ActiveRecord::Base

  validates :link, :url => true

  validates_presence_of :link

  has_many :link_hashtags
  has_many :faq_links

  has_many :hashtags, through: :link_hashtags
  has_many :faqs, through: :faq_links

  belongs_to :company
end
