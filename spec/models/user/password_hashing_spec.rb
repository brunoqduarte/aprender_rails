require "spec_helper"

describe User, "password_hashing" do
  subject(:user) {User.new}

  it "generates hash" do
    PasswordEncryptor.should_receive(:encrypt).with("teste")
    user.password = "teste"
  end

  it "sets hash" do
    PasswordEncryptor.stub :encrypt => "hash"
    user.password = "teste"
    expect(user.password_hash).to eql("hash")
  end

  it "sets password" do
    PasswordEncryptor.stub :encrypt
    user.password = "teste"
    expect(user.password).to eql("teste")
  end


end
