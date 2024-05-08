require 'rails_helper'

describe Application, type: :model do
  describe 'scopes' do 
    let_it_be(:job) { create(:job) }

    let_it_be(:hired_application) { create(:application, :hired, job_id: job.id) }
    let_it_be(:rejected_applications) { create_list(:application, 2, :rejected, job_id: job.id) }
    let_it_be(:applied_applications) { create_list(:application, 2, job_id: job.id) }
    let_it_be(:interviewed_applications) { create_list(:application, 3, :interviewed, job_id: job.id) }
    let_it_be(:noted_applications) { create_list(:application, 2, :noted, job_id: job.id) }

    describe '::hired' do
      it 'returns expected applications' do 
        applications = Application.hired

        expect(applications.pluck(:id)).to match_array([hired_application.id])
      end
    end

    describe '::rejected' do
      it 'returns expected applications' do 
        applications = Application.rejected
        
        expect(applications.pluck(:id)).to match_array(rejected_applications.pluck(:id))
      end
    end

    describe '::ongoing' do
      it 'returns expected applications' do 
        applications = Application.ongoing
        expected_ids = applied_applications.pluck(:id) + interviewed_applications.pluck(:id)
        
        expect(applications.pluck(:id)).to match_array(expected_ids)
      end
    end
  end

  describe 'instance public interface' do 
    let_it_be(:application) { create(:application, :with_job) }

    describe '#interview!' do 
      it 'creates an event record with expected type' do 
        expect {
          application.interview!(Time.zone.now)
        }.to change { Application::Event::Interview.count }.by(1)
      end
    end

    describe '#hire!' do 
      it 'creates an event record with expected type' do 
        expect {
          application.hire!(Time.zone.now)
        }.to change { Application::Event::Hired.count }.by(1)
      end
    end

    describe '#note!' do 
      it 'creates an event record with expected type' do 
        expect {
          application.note!('Some useful comment.')
        }.to change { Application::Event::Note.count }.by(1)
      end
    end

    describe '#reject!' do 
      it 'creates an event record with expected type' do 
        expect {
          application.reject!
        }.to change { Application::Event::Rejected.count }.by(1)
      end
    end

    describe '#status' do 
      context 'when no related events' do 
        let_it_be(:application) { create(:application, :with_job) }

        it 'returns an expected status' do
          expect(application.status).to eq(:applied)
        end
      end

      context 'when application os interviewed' do 
        let_it_be(:application) { create(:application, :with_job, :interviewed) }

        it 'returns an expected status' do
          expect(application.status).to eq(:interview)
        end
      end

      context 'when application os hired' do 
        let_it_be(:application) { create(:application, :with_job, :hired) }

        it 'returns an expected status' do
          expect(application.status).to eq(:hired)
        end
      end

      context 'when application os rejected' do 
        let_it_be(:application) { create(:application, :with_job, :rejected) }

        it 'returns an expected status' do
          expect(application.status).to eq(:rejected)
        end
      end
    end
  end
end
