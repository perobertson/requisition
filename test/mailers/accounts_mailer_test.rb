# frozen_string_literal: true

require 'test_helper'

class AccountsMailerTest < ActionMailer::TestCase
  let(:user) { User.first }
  let(:from) { ENV['MAILER_FROM_EMAIL'] }
  let(:token) { SecureRandom.uuid }

  it 'must generate confirmation instructions email' do
    mail = AccountsMailer.confirmation_instructions user, token

    mail.subject.must_equal 'Confirmation instructions'
    mail.to.must_equal [user.email]
    mail.from.must_equal [from]

    mail.body.encoded.must_match user.name
    mail.body.encoded.must_match token
  end

  it 'must generate password changed email' do
    mail = AccountsMailer.password_change user

    mail.subject.must_equal 'Password Changed'
    mail.to.must_equal [user.email]
    mail.from.must_equal [from]

    mail.body.encoded.must_match user.name
    mail.body.encoded.must_match 'password has been changed'
  end

  it 'must generate reset password email' do
    skip 'passwords are not managed by this app'
    mail = AccountsMailer.reset_password_instructions user, token

    mail.subject.must_equal 'Reset Password'
    mail.to.must_equal [user.email]
    mail.from.must_equal [from]

    mail.body.encoded.must_match user.name
  end

  it 'must generate unlock instructions email' do
    skip 'passwords are not managed by this app'
    mail = AccountsMailer.unlock_instructions user, token

    mail.subject.must_equal 'Unlock Instructions'
    mail.to.must_equal [user.email]
    mail.from.must_equal [from]

    mail.body.encoded.must_match user.name
  end
end
