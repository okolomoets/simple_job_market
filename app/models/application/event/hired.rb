class Application::Event::Hired < Application::Event
  self.status = :hired

  def date
    data['interview_date']
  end
end
