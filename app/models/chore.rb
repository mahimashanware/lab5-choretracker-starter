class Chore < ApplicationRecord
    belongs_to :child
    belongs_to :task
    scope :chronological, -> { order('due_on') }
    scope :by_task, -> { joins(:task).order('tasks.name') }
    scope :done, -> { where(completed: true) }
    scope :pending, -> { where(completed: false) }
    scope :upcoming, -> { where("due_on >= ?", Date.current) }
    scope :past, -> { where("due_on < ?", Date.current) }
    validates_date :due_on
    def status
        return "Completed" if self.completed
        "Pending"
    end
end
