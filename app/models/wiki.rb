class Wiki < ActiveRecord::Base

  belongs_to :user

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true

  extend FriendlyId
   friendly_id :title, use: [:slugged, :history]

  # def should_genereate_new_friendly_id?
  #   new_record?
  # end

end
