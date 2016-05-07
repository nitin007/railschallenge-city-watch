class Responder < ActiveRecord::Base
  validates :name, :capacity, :type, presence: true
  validates :name, uniqueness: true
  validates :capacity, inclusion: { in: (1..5) }
end
