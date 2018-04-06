# frozen_string_literal: true

class PurchasesController < ApplicationController
  before_action :check_app_setup, only: %i[index]

  def index
    for_sale = policy_scope(Item).joins(:category).for_sale.order :name
    @items = {}
    Category.names.each do |name|
      @items[name.to_sym] = for_sale.where categories: { name: name }
    end
  end

  def history
    @orders = current_user.orders.eager_load(order_items: :item).order created_at: :desc
  end

private

  def check_app_setup
    @missing_variables = []
    if ENV['EVE_APP_ID'].blank?
      @missing_variables.push key: 'EVE_APP_ID', message: 'Create an OAuth application for SSO - https://developers.eveonline.com/applications'
    end
    if ENV['EVE_APP_SECRET'].blank?
      @missing_variables.push key: 'EVE_APP_SECRET', message: 'Create an OAuth application for SSO - https://developers.eveonline.com/applications'
    end
    if ENV['MAILER_DOMAIN'].blank?
      @missing_variables.push key: 'MAILER_DOMAIN', message: 'Set this to the doman that email comes from - ex: google.com'
    end
    if ENV['MAILER_FROM_EMAIL'].blank?
      @missing_variables.push key: 'MAILER_FROM_EMAIL', message: 'Set this to the email that will be the sender of all outgoing emails'
    end
    if ENV['MAILER_HOST'].blank?
      @missing_variables.push key: 'MAILER_HOST', message: 'Set this to the domain name of the website where requisition is running so links in outgoing mail will be generated correctly'
    end
    if ENV['MAILER_REPLY_TO_EMAIL'].blank?
      @missing_variables.push key: 'MAILER_REPLY_TO_EMAIL', message: 'Set this to the email that people should reply to'
    end
    if ENV['REQUISITION_BUILDER_EMAIL'].blank?
      @missing_variables.push key: 'REQUISITION_BUILDER_EMAIL', message: 'Set this to the email of the corporation member responsible for building the items'
    end
    if ENV['SMTP_HOST'].blank?
      @missing_variables.push key: 'SMTP_HOST', message: 'Set this to the host domain of your email provider'
    end
    if ENV['SMTP_PASSWORD'].blank?
      @missing_variables.push key: 'SMTP_PASSWORD', message: 'Set this to the password for your email provider'
    end
    if ENV['SMTP_PORT'].blank?
      @missing_variables.push key: 'SMTP_PORT', message: 'Set this to the port for your email provider'
    end
    if ENV['SMTP_USERNAME'].blank?
      @missing_variables.push key: 'SMTP_USERNAME', message: 'Set this to the username of your email provider'
    end
    render 'setup' if @missing_variables.present?
  end
end
