class Job::Event < ApplicationRecord
  class_attribute :status
  
  self.table_name = 'job_events'

  scope :latest, -> { where(id: latest_ids) }

  def initialize(*args)
    raise "Cannot directly instantiate an Job::Event" if self.class == Job::Event
    super
  end

  private
  
  def self.latest_ids
    select('max(id) as id').group(:job_id)
  end
end
