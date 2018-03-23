# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/purchase_mailer
class PurchaseMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/purchase_mailer/purchase_order
  def purchase_order
    PurchaseMailer.purchase_order Order.all.sample
  end
end
