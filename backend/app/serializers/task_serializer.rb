class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :due_date, :project_id, :user_id, :created_at, :updated_at, :overdue, :due_soon

  def overdue
    object.overdue?
  end

  def due_soon
    object.due_soon?
  end
end

