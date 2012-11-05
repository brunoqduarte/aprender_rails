require "spec_helper"

describe User, "validations" do

  it "requires name" do
    user = User.create(:name => nil)
    expect(user).to have(1).error_on(:name)
  end

  it "requires email" do
    user = User.create(:email => nil)
    expect(user).to have(1).error_on(:email)
  end

  it "requires valid email" do
    user = User.create(:email => "sdasd")
    expect(user).to have(1).error_on(:email)
  end

  it "acepts valid email" do
    user = User.new(:email => "a@gmail.com")
    user.valid?
    expect(user).to have(:no).error_on(:email)
  end

  it "requires password" do
    user = User.create(:password => nil)
    expect(user).to have(1).error_on(:password)
  end

#  it "requires password confirmation" do
#    user = User.new(
#    			:password => "senha",
#    			:password_confirmarion => "adad")
#    expect(user).to have(1).error_on(:password)
#  end

  it "set password rash when set password" do
    user = User.new(:password => "teste")
    expect(user.password_hash).not_to be_blank
  end

  context "when updating attributes" do
    let!(:user){
      User.create!({
        :name => "John",
        :email => "John@gmail.com",
        :password => "teste",
        :password_confirmation => "teste"
      }).reload
    }

    it "validates password when password has been set" do
      user.password = nil
      user.valid?
      expect(user).to have_at_least(1).error_on(:password)
    end

    it "skips password validation when not setting password" do
      user.valid?
      expect(user).to have(:no).error_on(:password)
    end

  end

end
