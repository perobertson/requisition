# frozen_string_literal: true
require 'test_helper'

class PurchaseMailerTest < ActionMailer::TestCase
  describe 'purchase email' do
    let(:order) { orders(:order_mailer_test) }
    it 'must send purchase mail' do
      PurchaseMailer.purchase_order(order).deliver_now

      mail = ActionMailer::Base.deliveries.last
      mail.wont_be_nil
      mail.subject.must_include 'Order Placed'
      mail.to.must_include ENV['REQUISITION_BUILDER_EMAIL']
      mail.from.must_include ENV['MAILER_FROM_EMAIL']

      mail.encoded.must_include order.user.name
      order.order_items.each do |order_item|
        mail.encoded.must_include order_item.item.name
        mail.encoded.must_include order_item.quantity.to_s
      end
    end
  end
end
