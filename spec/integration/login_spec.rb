# -*- encoding: utf-8 -*-

require "spec_helper"

describe "Login" do
  context "with valid credentials" do
    let!(:user){
      User.create!({
        :name => "John Joe",
        :email => "john@example.com",
        :password => "test",
        :password_confirmation => "test"
      })
    }
    
    before do
      visit root_path
      click_link "Acessar minha conta"
      fill_in "Seu e-mail", :with => "brunoqduarte@gmail.com"
      fill_in "Sua senha", :with => "123456"
      click_button "Acessar minha conta"
    end

    it "redirects to home page" do
      expect(current_path).to eql(root_path)
    end

    it "display greeting message" do
      expect(page).to have_content("Olá, bruno")
    end

  end
  
  context "with invalid credentials" do
    before do
      visit root_path
      click_link "Quero me cadastrar"
      click_button "Quero me cadastrar"
    end
    
    it "display error messages" do
      expect(page).to have_content("Verifique o formulário antes de continuar:")
    end
    
  end

end
