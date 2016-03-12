module SessionHelpers
  def login_user(user = nil)
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in (user || FactoryGirl.create(:user))
    end
  end
end
