class Api::V1::Client::InvoicesController < ApplicationController
  include Sortable

  before_action :authenticate_api_user!, :require_client

  sortable_by 'projects.title', 'users.first_name'

  # GET /client/invoices
  def index
    invoices = sort(invoices_scope)
    render json: Client::InvoiceBlueprint.render(invoices, root: :list, meta: {
      open_count: invoices.sent.count,
      paid_count: invoices.paid.count,
    }) 
  end

  # GET /client/invoices/:id
  def show
    invoice = Invoice.find(params[:id])
    render json: Client::InvoiceBlueprint.render(invoice, view: :extended)
  end

  private

  def invoices_scope
    Invoice.joins(project: { freelancer_detail: :user })
        .where(projects: {client_detail_id: current_api_user.client_detail.id})
        .order(updated_at: :desc)
  end
end
