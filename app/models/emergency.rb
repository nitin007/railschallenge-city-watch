class Emergency < ActiveRecord::Base
  validates_numericality_of :fire_severity, :medical_severity, :police_severity, greater_than_or_equal_to: 0
  validates_uniqueness_of :code
end
