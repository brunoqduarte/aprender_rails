# -*- encoding: utf-8 -*-

require "spec_helper"

describe "Login" do
  context "with valid credentials" do
    before do
      visit root_path
      click_link "Quero me cadastrar"
      fill_in "Seu nome", :with => "John Doe"
      fill_in "Seu e-mail", :with => "john@example.org"
      fill_in "Sua senha", :with => "test"
      fill_in "Confirme sua senha", :with => "test"
      click_button "Quero me cadastrar"
    end

    it "redirects to the login page" do
      expect(current_path).to eql(login_path)
    end

    it "display succes message" do
      expect(page).to have_content("Usuário cadastrado com sucesso!")
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
