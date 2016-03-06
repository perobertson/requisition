# Preview all emails at http://localhost:3000/rails/mailers/accounts
class AccountsMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/accounts/confirmation_instructions
  def confirmation_instructions
    AccountsMailer.confirmation_instructions(User.first, 'faketoken', {})
  end

  # Preview this email at http://localhost:3000/rails/mailers/accounts/password_change
  def password_change
    AccountsMailer.password_change(User.first)
  end

  # Preview this email at http://localhost:3000/rails/mailers/accounts/reset_password_instructions
  def reset_password_instructions
    AccountsMailer.reset_password_instructions(User.first, 'faketoken', {})
  end

  # Preview this email at http://localhost:3000/rails/mailers/accounts/unlock_instructions
  def unlock_instructions
    AccountsMailer.unlock_instructions(User.first, 'faketoken', {})
  end
end
