require 'rails_helper'

describe Job, type: :model do
  describe 'scopes' do 
    let_it_be(:activated_jobs) { create_list(:job, 3, :activated) }
    let_it_be(:deactivated_jobs) { create_list(:job, 2, :deactivated) }
    let_it_be(:inactive_job) { create(:job) }

    describe '::activated' do 
      it 'returns only activated jobs' do 
        jobs = Job.activated
        expect(jobs.count).to eq(3)
        expect(jobs.pluck(:id)).to match_array(activated_jobs.pluck(:id))
      end
    end

    describe '::deactivated' do 
      it 'returns deactivated and inactive jobs' do 
        jobs = Job.deactivated
        expect(jobs.count).to eq(3)
        expected_ids = deactivated_jobs.pluck(:id) + [inactive_job.id]
        expect(jobs.pluck(:id)).to match_array(expected_ids)
      end
    end
  end

  describe 'instance public interface' do 
    describe '#activate!' do 
      let_it_be(:job) { create(:job) }

      it 'creates an event record with expected type' do 
        expect {
          job.activate!
        }.to change { Job::Event::Activated.count }.by(1)
      end
    end

    describe '#deactivate!' do 
      let_it_be(:job) { create(:job) }

      it 'creates an event record with expected type' do 
        expect {
          job.deactivate!
        }.to change { Job::Event::Deactivated.count }.by(1)
      end
    end

    describe '#status' do 
      context 'when no related events' do 
        let_it_be(:job) { create(:job) }

        it 'returns expected status' do
          expect(job.status).to eq(:deactivated)
        end
      end

      context 'when related event is activated' do 
        let_it_be(:job) { create(:job, :activated) }
        
        it 'returns expected status' do
          expect(job.status).to eq(:activated)
        end
      end

      context 'when related event is deactivated' do 
        let_it_be(:job) { create(:job, :deactivated) }
        
        it 'returns expected status' do
          expect(job.status).to eq(:deactivated)
        end
      end
    end
  end
end
