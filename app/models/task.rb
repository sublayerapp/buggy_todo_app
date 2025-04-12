class Task < ApplicationRecord
  scope :incomplete, -> { where(completed: [false, nil]) }
end
