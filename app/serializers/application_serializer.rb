class ApplicationSerializer < ActiveModel::Serializer
  attributes :id, :job_title, :candidate_name, :status, :notes_count, :interview_date

  def notes_count
    object.notes.count
  end

  def interview_date
    object.interview_date
  end
end
