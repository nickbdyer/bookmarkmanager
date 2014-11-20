module PasswordHelpers

  def request_password_reset(user)
    visit '/sessions/new'
    click_button "Forgot password?"
    expect(page).to have_content("Please enter your email")
    fill_in 'email', :with => user.email
    click_button "Forgot Password"
  end

end