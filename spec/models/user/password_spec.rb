require "spec_helper"

describe User, "password" do
  subject(:user){
    User.new({
      :name => "John",
      :email => "John@gmail.com",
      :password => "teste",
      :password_confirmation => "teste"
    })
  }

  it "cleans password after saving user" do
    user.save!
    expect(user.password).to be_nil
  end

end
