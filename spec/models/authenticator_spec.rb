require "spec_helper"

describe Authenticator do
  let(:user){mock("user").as_null_object}
  let(:repository) {mock("repository").as_null_object}
  let(:encryptor) { mock("encryptor") }
  
  before do
    stub_const("User", mock("User"))
    stub_const("PasswordEncryptor", mock("PasswordEncryptor"))
  end
  
  it "sets password encriptor" do
    expect(Authenticator.encryptor).to eql(PasswordEncryptor)
  end 
  
  it "sets repository" do
    expect(Authenticator.repository).to eql(User)
  end
  
  context "with valid data" do
    
    before do
      Authenticator.stub(
        :repository => repository,
        :encryptor => encryptor
      )
      
      repository.stub :find_by_email => user
      encryptor.stub :valid?
      user.stub :password_hash => "some hash"      
    end

    
    it "find user by email" do
      repository.should_receive(:find_by_email).with("jonj@example.com")
      Authenticator.authenticate("jonj@example.com", "test")
    end
    
    it "validates password" do
      encryptor
        .should_receive(:valid?)
        .with("some hash", "test")

      Authenticator.authenticate("john@example.org", "test")
    end
    
    it "returns user" do
      encryptor.stub :valid? => true
      authenticated = Authenticator.authenticate("john@example.org", "test")
      expect(authenticated).to eql(user)
    end
    
  end
  
  context "with invalid data" do
    before do
      Authenticator.stub({
        :repository => repository,
        :encryptor => encryptor
      })
    end
    
    it "returns nil when invalid email" do
      repository.stub :find_by_email => nil      
      authenticated = Authenticator.authenticate("john@example.com", "usuario")
      
      expect(authenticated).to be_nil
    end
    
    it "returns nil when using invalid password" do
      repository.stub :find_by_email => user
      encryptor.stub :valid? => false
      user.stub :password_hash => "hash"
      authenticated = Authenticator.authenticate("john@example.com", "usuario")
      expect(authenticated).to be_nil
    end 
    
    
  end
end
