require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new
    @user.first_name = "First"
    @user.last_name = "Last"
    @user.email = "first.last@email.com"
    @user.password = "password"
    @user.password_confirmation = "password"
  end

  describe "Validations" do
    it "should validate User" do  
      @user.save
      expect(@user).to be_valid
    end

    it "should validate User email is nil" do
      @user.email = nil
      @user.save
      # byebug
      expect(@user).to_not be_valid
      
      expect(@user.errors.full_messages.first).to eq("Email can't be blank")
    end

    it "should validate User first name is nil" do
      @user.first_name = nil
      @user.save
      # byebug
      expect(@user).to_not be_valid
      
      expect(@user.errors.full_messages.first).to eq("First name can't be blank")
    end

    it "should validate User last name is nil" do
      @user.last_name = nil
      @user.save
      # byebug
      expect(@user).to_not be_valid
      
      expect(@user.errors.full_messages.first).to eq("Last name can't be blank")
    end

    it "should validate password and confirm password match" do
      @user.password_confirmation = "error"
      @user.save
      # byebug
      expect(@user.password).to_not eq(@user.password_confirmation)
      
      expect(@user.errors.full_messages.first).to eq("Password confirmation doesn't match Password")
    end

    it "should validate User password is nil" do
      @user.password = nil
      @user.save
      # byebug
      expect(@user).to_not be_valid
      
      expect(@user.errors.full_messages.first).to eq("Password can't be blank")
    end

    it "should validate User password confirmation is nil" do
      @user.password_confirmation = nil
      @user.save
      # byebug
      expect(@user).to_not be_valid
      
      expect(@user.errors.full_messages.first).to eq("Password confirmation can't be blank")
    end

    it "should validate User password minimum legth is 5" do
      @user.password = "pass"
      @user.password_confirmation = "pass"
      @user.save
      # byebug
      expect(@user).to_not be_valid
      
      expect(@user.errors.full_messages.first).to eq("Password is too short (minimum is 5 characters)")
    end

    it "should validate User email is unique" do
      @user_new = User.new
      @user_new.first_name = "First"
      @user_new.last_name = "Last"
      @user_new.email = "first.LAST@email.com"
      @user_new.password = "password"
      @user_new.password_confirmation = "password"

      @user.email.downcase
      @user_new.email.downcase
 
      @user.save
      @user_new.save
      # byebug
      expect(@user_new).to_not be_valid
      expect(@user_new.errors.full_messages.first).to eq("Email has already been taken")
    end
  end
  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "should successfully authenticate" do
      @user.save
      @user_authenticate = User.authenticate_with_credentials("first.LAST@email.com", "password")
      expect(@user).to eq(@user_authenticate)
    end

    it "should successfully authenticate with whitespaces in email" do
      @user.save
      @user_authenticate = User.authenticate_with_credentials("    first.LAST@email.com   ", "password")
      expect(@user).to eq(@user_authenticate)
    end

    it "should successfully authenticate with wrong case for email" do
      @user.save
      @user_authenticate = User.authenticate_with_credentials("    first.LAST@email.com   ", "password")
      expect(@user).to eq(@user_authenticate)
    end
  end
end
