class Faq < ActiveRecord::Base
  validates_presence_of :question, :answer

  belongs_to :company
  has_many :faq_hashtags
  has_many :hashtags, through: :faq_hashtags
end
