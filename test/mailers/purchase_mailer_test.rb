require 'test_helper'

class PurchaseMailerTest < ActionMailer::TestCase
  describe 'purchase email' do
    it 'must send purchase mail' do
      order = orders(:order_mailer_test)

      PurchaseMailer.purchase_order(order).deliver_now

      mail = ActionMailer::Base.deliveries.last
      mail.wont_be_nil
      mail.subject.must_include 'Order Placed'
      mail.encoded.must_include order.character_name
      order.order_items.each do |order_item|
        mail.encoded.must_include order_item.item.name
        mail.encoded.must_include order_item.quantity.to_s
      end
      mail.to.must_include ENV['REQUISITION_BUILDER_EMAIL']
    end
  end
end
