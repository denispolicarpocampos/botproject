class Link < ActiveRecord::Base
  validates_presence_of :link

  belongs_to :company

  has_many :hashtags, through: :link_hashtags
  has_many :link_hashtags
end
