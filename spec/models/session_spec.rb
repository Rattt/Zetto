require 'rails_helper'

module Zetto
  RSpec.describe Session, type: :model do

    subject(:zetto_session) { FactoryGirl.build :zetto_session }

    describe 'simple  validation' do

      context "with empty arguments" do

        it 'user_id is should not be empty' do
          subject.user_id = ''
          expect(subject).to_not be_valid
        end

        it 'session_id is should not be empty' do
          subject.session_id = ''
          expect(subject).to_not be_valid
        end

        it 'algorithm is should not be empty' do
          subject.algorithm = ''
          expect(subject).to_not be_valid
        end

      end

      context "with correct arguments" do

        it 'filled data must be validly' do
          expect(subject).to be_valid
        end

      end

    end


    describe 'validate dublicate' do

      let(:zetto_session_two) { FactoryGirl.build :zetto_session_two }

      it 'not save dublicate object' do
        subject.save
        expect(subject.class.new(subject.attributes)).to_not be_valid
      end

      it 'not save dublicate user_id' do
        subject.save
        zetto_session_two.user_id = subject.user_id
        expect(zetto_session_two).to_not be_valid
      end

      it 'not save dublicate session_id' do
        subject.save
        zetto_session_two.session_id = subject.session_id
        expect(zetto_session_two).to_not be_valid
      end

      it 'correct save two records' do
        subject.save
        expect(zetto_session).to be_valid
      end

    end

    describe 'object must include' do
      it 'contains an admissible set of enciphering' do
        expect(['sha1', 'md5']).to include(subject.algorithm)
      end
    end

  end



end
