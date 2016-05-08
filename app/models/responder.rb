class Responder < ActiveRecord::Base
  validates :name, :capacity, :type, presence: true
  validates :name, uniqueness: true
  validates :capacity, inclusion: { in: (1..5) }

  def to_param
    name.parameterize
  end
end
