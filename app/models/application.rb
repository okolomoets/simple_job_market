class Application < ApplicationRecord

  belongs_to :job
  has_many :events, class_name: 'Application::Event'
  has_many :notes, class_name: 'Application::Event::Note'
  has_many :interviews, class_name: 'Application::Event::Interview'

  scope :hired, -> { joins(:events).includes(:events).merge(Application::Event::Hired.latest) }
  scope :rejected, -> { joins(:events).includes(:events).merge(Application::Event::Rejected.latest) }
  scope :ongoing, -> do 
    left_joins(:events).includes(:events).
    merge(Application::Event::Interview.latest).
    or(Application::Event.where(application_id: nil))
  end
  
  delegate :title, to: :job, prefix: true

  def interview!(date)
    Application::Event::Interview.create(
      application_id: id,
      data: { interview_date: date }
    )
  end

  def hire!(date)
    Application::Event::Hired.create(
      application_id: id,
      data: { date: date }
    )
  end

  def reject!
    Application::Event::Rejected.create(application_id: id)
  end

  def note!(body)
    Application::Event::Note.create(
      application_id: id,
      data: { content: body }
    )
  end

  def interview_date
    interviews.last&.date
  end

  def status
    return :applied if last_event.nil?
    
    last_event.status
  end

  private 

  def last_event
    @event ||= events.last
  end
end
