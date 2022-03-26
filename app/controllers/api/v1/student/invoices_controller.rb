class Api::V1::Student::InvoicesController < ApplicationController
  include Sortable

  before_action :authenticate_api_user!, :require_client

  sortable_by 'projects.title', 'users.first_name'

  # GET /student/invoices
  def index
    invoices = sort(invoices_scope)
    render json: Student::InvoiceBlueprint.render(invoices, root: :list, meta: {
      open_count: invoices.sent.count,
      paid_count: invoices.paid.count,
    }) 
  end

  # GET /student/invoices/:id
  def show
    invoice = Invoice.find(params[:id])
    render json: Student::InvoiceBlueprint.render(invoice, view: :extended)
  end

  private

  def invoices_scope
    Invoice.joins(project: { tutor_detail: :user })
        .where(projects: {student_detail_id: current_api_user.student_detail.id})
        .order(updated_at: :desc)
  end
end
