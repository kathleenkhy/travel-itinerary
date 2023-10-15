class Trip < ApplicationRecord
  belongs_to :user
  has_many :itineraries

  def date_range
    range = (self.start..self.end).to_a
    return range
  end
end
