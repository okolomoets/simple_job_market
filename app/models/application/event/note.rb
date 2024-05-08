class Application::Event::Note < Application::Event
  self.status = nil

  def content
    data['content']
  end
end