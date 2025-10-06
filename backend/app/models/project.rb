class Project < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :tasks, dependent: :destroy

  # Validations
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :description, length: { maximum: 1000 }

  # Scopes
  scope :recent, -> { order(created_at: :desc) }

  # Instance methods
  def task_counts
    {
      total: tasks.count,
      todo: tasks.todo.count,
      in_progress: tasks.in_progress.count,
      completed: tasks.completed.count
    }
  end

  def completion_percentage
    return 0 if tasks.count.zero?
    
    (tasks.completed.count.to_f / tasks.count * 100).round(2)
  end
end
