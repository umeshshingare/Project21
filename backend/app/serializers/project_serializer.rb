class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :user_id, :created_at, :updated_at, :task_counts, :completion_percentage

  def task_counts
    object.task_counts
  end

  def completion_percentage
    object.completion_percentage
  end
end

