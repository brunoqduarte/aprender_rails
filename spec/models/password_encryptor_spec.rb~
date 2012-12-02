require "spec_helper"

describe PasswordEncryptor do

  let(:encryptor) {mock("encryptor")}

  it "sets encryptor to BCrypt" do
    expect(PasswordEncryptor.encryptor).to eql(BCrypt::Password)
  end

  context "encrypting password" do

    before do
      PasswordEncryptor.stub :encryptor => encryptor
    end

    it "encryps password" do
      encryptor.should_receive(:create).with("teste")
      PasswordEncryptor.encrypt("teste")
    end
  end

   context "validating password" do

    before do
      PasswordEncryptor.stub :encryptor => encryptor
    end

    it "instantiates encryptor" do
      encryptor.should_receive(:new).with("some hash")
      PasswordEncryptor.valid?("some hash", "teste")
    end

    it "valid when password is correct" do
      encryptor.stub :new => "teste"
      expect(PasswordEncryptor).to be_valid("some hash", "teste")
    end

     it "invalid when password is incorrect" do
      encryptor.stub :new => "teste"
      expect(PasswordEncryptor).not_to be_valid("some hash", "senha errada")
    end
  end
end
