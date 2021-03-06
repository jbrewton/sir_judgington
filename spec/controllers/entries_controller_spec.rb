require "rails_helper"

describe EntriesController, type: :controller do
  before :each do
    allow(Entry).to receive(:create!) { true }
  end

  describe 'index' do
    subject { get :index, {  } }
    it { is_expected.to be_success }
  end

  describe 'new' do
    subject { get :new, {  } }
    it { is_expected.to be_success }
  end

  describe 'create' do
    subject { post :create, {  } }
    it { is_expected.to be_redirect }
  end
end
