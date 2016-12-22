require 'rails_helper'

describe ApplicationController do

  describe "Check of inclusion of methods" do

    it "#authorization  has to be included" do
      expect(subject).to respond_to(:authorization)
    end

    it "#current_user  has to be included" do
      expect(subject).to respond_to(:current_user)
    end

    it "#logout  has to be included" do
      expect(subject).to respond_to(:logout)
    end

  end

  describe 'check_session' do


    let(:test_user_ivan_before_save)         { FactoryGirl.build :user_ivan }
    let(:test_user_ivan)                     { FactoryGirl.create :user_ivan }

    let(:user_existing_without_signed_model)             { FactoryGirl.create :cat_user }
    let(:user_existing_without_signed_model_before_save) { FactoryGirl.build  :cat_user }


    describe "create new session" do

      context 'when signed model' do

        it "#authorization with the nonexistent user  be nil" do
          expect(subject.authorization('User', 'bad_user', 'bad_password')).to be_nil
        end

        it "#authorization with existing user be hashed string" do
          expect(subject.authorization('User', test_user_ivan.email, test_user_ivan_before_save.password)).to be_kind_of(String)
        end

      end

      context 'without signed model' do

        it "#authorization with the nonexistent user  be nil" do
          expect(subject.authorization('Cat', 'bad_user', 'bad_password')).to be_nil
        end

        it "#authorization with existing user be nil" do
          expect(subject.authorization('Cat', user_existing_without_signed_model.email, user_existing_without_signed_model_before_save.password)).to be_nil
        end

      end

    end

    describe "get user by cookie" do

      let(:cookie_vlaue) { subject.authorization('User', test_user_ivan.email, test_user_ivan_before_save.password) }

      it "#current_user get user by cokie" do
        Test::Emulators::Cookie.set_cokie_rembo(cookie_vlaue)
        expect(subject.current_user).to be_kind_of(User)
      end

      it "#current_user get nil by badly cokie" do
        Test::Emulators::Cookie.set_cokie_rembo(cookie_vlaue.chop)
        expect(subject.current_user).to be_nil
      end

    end


  end

end


