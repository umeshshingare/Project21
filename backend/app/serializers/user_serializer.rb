class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :full_name, :role, :created_at, :updated_at

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end

