class Task < ActiveRecord::Base
  belongs_to :board

  scope :incompleted, ->{ where(completed_at: nil) }
  scope :completed, ->{ where.not(completed_at: nil) }
end
