class Job < ApplicationRecord

  has_many :applications
  has_many :events, class_name: "Job::Event"

  scope :activated, -> { joins(:events).includes(:events).merge(Job::Event::Activated.latest) }
  scope :deactivated, -> do 
    left_joins(:events).includes(:events).
    merge(Job::Event::Deactivated.latest).or(Job::Event.where(job_id: nil))
  end

  delegate :hired, :rejected, :ongoing, to: :applications, prefix: true

  def activate!
    Job::Event::Activated.create(job_id: id)
  end

  def deactivate!
    Job::Event::Deactivated.create(job_id: id)
  end

  def status
    return :deactivated if last_event.nil?
    
    last_event.status
  end

  private 

  def last_event
    @event ||= events.last
  end
end
