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
    (self.fire_severity.zero? || capacities['Fire'].any?{|c| c >= self.fire_severity }) && (self.police_severity.zero? || capacities['Police'].any?{|c| c >= self.police_severity }) && (self.medical_severity.zero? || capacities['Medical'].any?{|c| c >= self.medical_severity })
  end

  def capacities
    @capacities ||= Responder.capacities_per_group
  end

  def sorted_group_responders
    @sorted ||= group_responders.each{|type, responders| group_responders[type] = responders.sort_by(&:capacity) }
  end

  def responders
    {fire_severity: 'Fire', police_severity: 'Police', medical_severity: 'Medical'}.inject([]) do |ary, type|
      severity = type.to_a
      res = sorted_group_responders[severity[1]].detect{|res| res.capacity == self.send(severity[0]) } if sorted_group_responders[severity[1]]
      ary << res.name if res
      ary
    end
  end

  def group_responders
    @group_res ||= Responder.all.group_by(&:type)
  end
end
