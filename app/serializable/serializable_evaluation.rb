class SerializableEvaluation < JSONAPI::Serializable::Resource
  type 'evaluations'
  attribute :comment
  attribute :score
  attribute :easiness
  attribute :grading
  attribute :upvotes_count
  attribute :downvotes_count
  attribute :upvoted
  attribute :downvoted
  attribute :created_at
  attribute :updated_at
  belongs_to :semester
  belongs_to :lecture
  belongs_to :lecture_session

  attribute :can_update do
    @current_ability.can? :update, @object
  end

  attribute :can_destroy do
    @current_ability.can? :destroy, @object
  end
end
