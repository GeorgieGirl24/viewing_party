require 'rails_helper'

describe 'login' do
  describe 'as a visitor' do
    describe "when I visit the welcome page" do
      before :each do
        @user = User.create(
          email: 'testing@example.com',
          password: '1234**USAusa',
          password_confirmation: '1234**USAusa'
        )
        visit "/"
      end
      it 'I can login' do
        click_on 'Login'
        expect(current_path).to eq("/login")

        fill_in 'email', with: 'testing@example.com'
        fill_in 'password', with: '1234**USAusa'

        click_on "Login"
        expect(current_path).to eq("/dashboard")
      end

      it 'I cannot login with invalid email' do
        click_on 'Login'
        expect(current_path).to eq("/login")

        fill_in 'email', with: 'user@example.com'
        fill_in 'password', with: '1234**USAusa'

        click_on "Login"
        expect(page).to have_content("Your email or password was incorrect!")
        expect(current_path).to eq("/login")
      end

      it 'I cannot login with invalid password' do
        click_on 'Login'
        expect(current_path).to eq("/login")

        fill_in 'email', with: 'testing@example.com'
        fill_in 'password', with: 'password'

        click_on "Login"
        expect(page).to have_content("Your email or password was incorrect!")
        expect(current_path).to eq("/login")
      end
    end
  end
end