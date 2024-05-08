require 'rails_helper'

describe Api::V1::JobsController, type: :controller do
  describe 'GET index' do 
    let_it_be(:job) { create(:job) }

    it 'returns a successful response'  do
      get :index

      expect(response).to be_successful
      expect(response).to match_response_schema('v1/schemas/jobs')
    end

    context 'when job has someone hired' do 
      before { create(:application, :hired, job: job) }

      it 'returns expected number'  do
        get :index

        expected_job = response_json.find { |j| j[:id] == job.id }
        
        expect(expected_job[:hired_count]).to eq(1)
      end
    end

    context 'when job has someone rejected' do 
      before { create_list(:application, 2, :rejected, job: job) }

      it 'returns expected number'  do
        get :index

        expected_job = response_json.find { |j| j[:id] == job.id }
        
        expect(expected_job[:rejected_count]).to eq(2)
      end
    end

    context 'when job has ongoing applications' do 
      before do 
        create_list(:application, 2, :interviewed, job: job) 
        create(:application, job: job) 
      end

      it 'returns expected number'  do
        get :index

        expected_job = response_json.find { |j| j[:id] == job.id }
        
        expect(expected_job[:ongoing_count]).to eq(3)
      end
    end

    describe 'filters' do
      let_it_be(:activated_job) { create(:job, :activated) }
      let_it_be(:deactivated_job) { create(:job, :deactivated) }

      context 'when no params passed' do 
        it 'returns all jobs' do
          get :index

          expect(response_json.count).to eq(3)
          expect(response_json.map { |j| j[:id] }).to match_array(Job.pluck(:id))
        end
      end

      context 'when activated requested' do
        it 'returns activated jobs' do
          get :index, params: { status: 'activated' }
          expect(response_json.count).to eq(1)
          expect(response_json.map { |j| j[:id] }).to match_array([activated_job.id])
        end
      end

      context 'when deactivated requested' do
        it 'returns deactivated jobs' do
          get :index, params: { status: 'deactivated' }

          expect(response_json.count).to eq(2)
          expect(response_json.map { |j| j[:id] }).to match_array([job.id, deactivated_job.id])
        end
      end

      context 'when unsupported status is passed' do 
        it 'responds with error' do
          get :index, params: { status: 'unsupported' }
          
          expect(response).not_to be_successful
          expect(response_json).to eq(
            'Status unsupported is not supported. Supported statuses: [:activated, :deactivated]'
          )
        end
      end
    end
  end
end
