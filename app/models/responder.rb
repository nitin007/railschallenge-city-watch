class Responder < ActiveRecord::Base
  validates :name, :capacity, :type, presence: true
  validates :name, uniqueness: true
  validates :capacity, inclusion: { in: (1..5) }

  def to_param
    name.parameterize
  end

  def self.capacities_per_group
    self.all.inject(Hash.new{|h, k| h[k] = [] }) do |hash, responder|
      hash[responder.type] << responder.capacity
      hash
    end
  end
end
