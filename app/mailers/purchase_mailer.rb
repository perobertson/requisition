class PurchaseMailer < ActionMailer::Base
  #default from: "from@example.com"

  def purchase_order(order)
    @order = order
    mail(to: "#{ENV['REQUISITION_BUILDER_EMAIL']}", subject: "[TEST] Order Placed")
  end
end
