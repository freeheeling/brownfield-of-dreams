class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }, dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  validates :title, presence: true
  validates :description, presence: true
  validates :thumbnail, presence: true

  def self.no_classroom
    where(classroom: false)
  end
end
