module Feature
  module SessionHelpers
    def login_user(user = nil)
      user = (user || FactoryGirl.create(:user))
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end


    def sign_up_with(name, username, email, password)
      visit new_user_registration_path
      fill_in 'Name', with: name
      fill_in 'Username', with: username
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign up'
    end
  end
end