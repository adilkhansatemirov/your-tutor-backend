class Api::V1::Admin::InvoicesController < ApplicationController
  include Filterable
  include Searchable
  include Sortable

  before_action :authenticate_api_user!, :require_admin

  filterable_by 'invoice_status'
  sortable_by 'invoices.invoice_date', 'clients.first_name', 'freelancers.first_name', 'projects.title'

  # GET /admin/invoices
  def index
    invoices = sort(search(filter(invoices_scope)))
    result = invoices.page(params[:page]).per(per_page)
    render json: Admin::InvoiceBlueprint.render(result, root: :list, meta: {
      pagination: page_info(result),
      counters: {
        sent_count: invoices_scope.sent.count,
        draft_count: invoices_scope.draft.count,
        paid_count: invoices_scope.paid.count,
        error_count: invoices_scope.error.count,
      }
    })
  end

  # GET /admin/invoices/:id
  def show
    invoice = Invoice.find(params[:id])
    render json: Admin::InvoiceBlueprint.render(invoice, view: :extended)
  end

  # POST /admin/invoices
  def create
    outcome = Admin::InvoicesService.create_invoice(invoice_create_params)
    render json: { message: outcome[:message] }, status: outcome[:status]
  end

  # PUT /admin/invoices/:id
  def update
    outcome = Admin::InvoicesService.update_invoice(invoice_update_params, params[:id])
    render json: { message: outcome[:message] }, status: outcome[:status]
  end

  # POST /admin/invoices/:id/charge_client
  def charge_client
    outcome = Admin::InvoicesService.charge_client(params[:id])
    render json: { message: outcome[:message] }, status: outcome[:status]
  end

  private

  def invoices_scope
    Invoice.joins("INNER JOIN projects on invoices.project_id = projects.id")
        .joins("INNER JOIN client_details on projects.client_detail_id = client_details.id")
        .joins("INNER JOIN freelancer_details on projects.freelancer_detail_id = freelancer_details.id")
        .joins("INNER JOIN users as clients on client_details.user_id = clients.id")
        .joins("INNER JOIN users as freelancers on freelancer_details.user_id = freelancers.id")
        .order(updated_at: :desc)
  end

  def invoice_create_params
    params.require(:invoice).permit(:id, :invoice_date, :invoice_status, :project_id,
      invoice_items: [:id, :invoice_id, :item, :qty, :price, :time_entry_id])
  end

  def invoice_update_params
    params.require(:invoice).permit(:id, :invoice_status,
      items_to_create: [:id, :invoice_id, :item, :qty, :price, :time_entry_id],
      items_to_update: [:id, :invoice_id, :item, :qty, :price, :time_entry_id],
      items_to_delete: [:id, :invoice_id, :item, :qty, :price, :time_entry_id],
    )
  end
end
