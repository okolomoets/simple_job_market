require 'rails_helper'

describe Application::Event, type: :model do
  describe '::new' do
    it 'raises an error' do 
      expect {
        Application::Event.new
    }.to raise_error { NoMethodError }
    end
  end

  describe 'scopes' do 
    let_it_be(:application1) { create(:application, :with_job) }
    let_it_be(:interview_event1) { create(:application_event_interview, application_id: application1.id) }
    let_it_be(:rejected_event1) { create(:application_event_rejected, application_id: application1.id) }
    
    let_it_be(:application2) { create(:application, :with_job) }
    let_it_be(:interview_event2) { create(:application_event_interview, application_id: application2.id) }
    let_it_be(:note_event2) { create(:application_event_note, application_id: application2.id) }

    describe '::latest' do 
      it 'returns only latest events per application' do 
        events = Application::Event.latest
        expect(events.count).to eq(2)
        expect(events.pluck(:id)).to match_array([rejected_event1.id, interview_event2.id])
      end
    end
  end
end
