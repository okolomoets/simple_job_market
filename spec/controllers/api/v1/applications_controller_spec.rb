require 'rails_helper'

describe Api::V1::ApplicationsController, type: :controller do
  describe 'GET index' do 
    let_it_be(:applications) { create_list(:application, 2, :with_job) }

    it 'returns a successful response'  do
      get :index

      expect(response).to be_successful
      expect(response).to match_response_schema('v1/schemas/applications')
    end

    context 'when application has some notes' do 
      let_it_be(:job) { create(:job, :activated) }
      let_it_be(:application_with_note) { create(:application, :noted, :noted, job: job) }

      it 'returns expected number'  do
        get :index

        application = response_json.find { |application| application[:id] == application_with_note.id }
        
        expect(application[:notes_count]).to eq(2)
      end
    end

    context 'when application is interviewed' do 
      let_it_be(:job) { create(:job, :activated) }
      let_it_be(:application_with_note) { create(:application, :noted, :interviewed, job: job) }

      it 'returns expected number'  do
        get :index

        application = response_json.find { |application| application[:id] == application_with_note.id }
        
        expect(application[:interview_date]).not_to be_nil
      end
    end

    describe 'filters' do
      let_it_be(:activated_job) { create(:job, :activated) }
      let_it_be(:deactivated_job) { create(:job, :deactivated) }
      let_it_be(:activated_application) { create(:application, job: activated_job) }
      let_it_be(:deactivated_application) { create(:application, job: deactivated_job) }

      context 'when no params passed' do 
        it 'returns applications for activated jobs' do
          get :index

          expect(response_json.count).to eq(1)
          expect(response_json.map { |j| j[:id] }).to match_array(activated_application.id)
        end
      end

      context 'when activated requested' do
        it 'returns applications for activated jobs' do
          get :index, params: { status: 'activated' }

          expect(response_json.count).to eq(1)
          expect(response_json.map { |j| j[:id] }).to match_array(activated_application.id)
        end
      end

      context 'when deactivated requested' do
        it 'returns applications for deactivated jobs' do
          get :index, params: { status: 'deactivated' }

          expect(response_json.count).to eq(3)
          expected_ids = applications.pluck(:id) << deactivated_application.id

          expect(response_json.map { |j| j[:id] }).to match_array(expected_ids)
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
