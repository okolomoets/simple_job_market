FactoryBot.define do
  factory :application_event_hired, class: Application::Event::Hired do 
    application_id { }
  end
  
  factory :application_event_interview, class: Application::Event::Interview do 
    application_id { }
  end

  factory :application_event_note, class: Application::Event::Note do 
    application_id { }
  end

  factory :application_event_rejected, class: Application::Event::Rejected do 
    application_id { }
  end
end