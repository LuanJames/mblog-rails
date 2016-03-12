module Features
  module SessionHelpers
    def sign_up_with(name, username, email, password)
      visit new_user_registration_path
      fill_in 'Name', with: name
      fill_in 'Username', with: username
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign up'
    end

    def sign_in
      user = create(:user)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
    end
  end
end