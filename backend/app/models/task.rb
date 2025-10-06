class Task < ApplicationRecord
  # Associations
  belongs_to :project
  belongs_to :user

  # Enums
  enum status: { todo: 0, in_progress: 1, completed: 2 }

  # Validations
  validates :title, presence: true, length: { minimum: 2, maximum: 200 }
  validates :description, length: { maximum: 1000 }
  validates :status, presence: true

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :by_status, ->(status) { where(status: status) }
  scope :overdue, -> { where('due_date < ? AND status != ?', Time.current, statuses[:completed]) }
  scope :due_soon, -> { where(due_date: Time.current..1.week.from_now) }

  # Callbacks
  after_update :broadcast_task_update, if: :saved_change_to_status?

  # Instance methods
  def overdue?
    due_date && due_date < Time.current && !completed?
  end

  def due_soon?
    due_date && due_date.between?(Time.current, 1.week.from_now)
  end

  private

  def broadcast_task_update
    ActionCable.server.broadcast(
      "project_#{project_id}",
      {
        type: 'task_updated',
        task: {
          id: id,
          title: title,
          status: status,
          user_id: user_id
        }
      }
    )
  end
end
