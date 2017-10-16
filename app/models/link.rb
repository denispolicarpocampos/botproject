class Link < ActiveRecord::Base

  validates_format_of :link, :with => %r"\A(https?://)?[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{2,6}(/.*)?\Z"i


  validates_presence_of :link

  has_many :link_hashtags
  has_many :faq_links

  has_many :hashtags, through: :link_hashtags
  has_many :faqs, through: :faq_links

  belongs_to :company
end
