class Application::Event::Interview < Application::Event
  self.status = :interview

  def date
    data['interview_date']
  end
end
