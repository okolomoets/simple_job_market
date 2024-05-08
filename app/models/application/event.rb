class Application::Event < ApplicationRecord
  class_attribute :status
  
  self.table_name = 'application_events'

  scope :latest, -> { where(id: latest_ids) }

  def initialize(*args)
    raise "Cannot directly instantiate an Application::Event" if self.class == Application::Event
    super
  end

  private

  NON_STATUS_EVENTS = [
    Application::Event::Note.name
  ].freeze

  def self.latest_ids 
    select('max(id) as id').where.not(type: NON_STATUS_EVENTS).group(:application_id)
  end
end
