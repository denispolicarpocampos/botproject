require "pg_search"
include PgSearch

class Faq < ActiveRecord::Base
  validates_presence_of :question, :answer

  has_many :faq_hashtags
  has_many :hashtags, through: :faq_hashtags

  has_many :faq_links
  has_many :links, through: :faq_links

  belongs_to :company

  # include PgSearch
  pg_search_scope :search, :against => [:question, :answer]
end
