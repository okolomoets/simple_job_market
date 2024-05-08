class JobSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :hired_count, :rejected_count, :ongoing_count

  def hired_count
    object.applications_hired.count
  end

  def rejected_count
    object.applications_rejected.count
  end

  def ongoing_count
    object.applications_ongoing.count
  end
end
