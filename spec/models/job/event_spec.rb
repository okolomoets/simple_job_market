require 'rails_helper'

describe Job::Event, type: :model do
  describe '::new' do
    it 'raises an error' do 
      expect {
        Job::Event.new
    }.to raise_error { NoMethodError }
    end
  end

  describe 'scopes' do 
    let_it_be(:job1) { create(:job) }
    let_it_be(:activated_event1) { create(:job_event_activated, job_id: job1.id) }
    let_it_be(:deactivated_event1) { create(:job_event_deactivated, job_id: job1.id) }
    
    let_it_be(:job2) { create(:job) }
    let_it_be(:deactivated_event2) { create(:job_event_deactivated, job_id: job2.id) }
    let_it_be(:activated_event2) { create(:job_event_activated, job_id: job2.id) }

    describe '::latest' do 
      it 'returns only latest events per job' do 
        events = Job::Event.latest
        expect(events.count).to eq(2)
        expect(events.pluck(:id)).to match_array([deactivated_event1.id, activated_event2.id])
      end
    end
  end
end
