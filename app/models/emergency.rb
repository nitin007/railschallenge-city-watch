class Emergency < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  validates :fire_severity, :police_severity, :medical_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :resolved, -> { where("resolved_at <= #{Time.zone.now}") }

  def to_param
    code.parameterize
  end

  def self.with_full_response
    Emergency.all.select { |e| e.responders_available? }
  end

  def responders_available?
    (self.fire_severity.zero? || capacities['Fire'].any?{|c| c >= self.fire_severity }) && (self.police_severity.zero? || capacities['Police'].any?{|c| c >= self.police_severity }) && (self.medical_severity.zero? || capacities['medical'].any?{|c| c >= self.medical_severity })
  end

  def capacities
    @capacities ||= Responder.capacities_per_group
  end
end
