class Api::V1::Admin::PaymentsController < ApplicationController
  before_action :authenticate_api_user!, :require_admin
  include Searchable
  include Sortable

  sortable_by 'payments.net_amount', 'payments.full_amount', 'payments.stripe_fee', 'payments.updated_at'

  def index
    payments = sort(search(Payment.all.order(updated_at: :desc)))
    result = payments.page(params[:page]).per(per_page)
    balance = Stripe::Balance.retrieve()
    render json: Admin::PaymentBlueprint.render(result, root: :list, meta: { pagination: page_info(result), balance: balance.available[0].amount.to_f / 100.0 })
  end
end
