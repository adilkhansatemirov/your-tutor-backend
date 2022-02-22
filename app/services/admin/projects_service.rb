module Admin::ProjectsService

  def self.create_project(params)
    project = Project.new(params[:project])
    project.save
    if params[:project][:freelancer_detail_id]
      approve_freelancer(params[:project][:freelancer_detail_id])
    end
    bids = Admin::ProjectBidsService.create_mutiple(params[:project_bids], project)
    Admin::ProjectBidsMailingJob.perform_later(bids)
  end

  def self.update_project(params, project_id)
    project = Project.find(project_id)
    if params[:freelancer_detail_id]
      approve_freelancer(params[:freelancer_detail_id])
    end
    project.update(params)
  end

  def self.assign_freelancer(params, project_id)
    project = Project.find(project_id)
    if project.update(params)
      ProjectBid.where(:project_id => project_id).destroy_all
    end
  end

  def self.start_bids(params, project_id)
    project = Project.find(project_id)
    project.update(params[:project])
    bids = Admin::ProjectBidsService.create_mutiple(params[:project_bids], project)
    Admin::ProjectBidsMailingJob.perform_later(bids)
  end

  def self.uninvoiced_time_entries(project_id)
    time_entries = []
    project = Project.find(project_id)
    project.timesheets.each do |timesheet|
      if timesheet.timesheet_status == "approved" || timesheet.timesheet_status == "paid"
        timesheet.time_entries.each do |time_entry|
          if !time_entry.invoiced
            time_entries.push(time_entry)
          end
        end
      end
    end
    time_entries
  end

  def self.pay_freelancer(params, project_id)
    project = Project.find(project_id)
    user = project.freelancer_detail.user

    unless user.freelancer_detail.connected_account_id
      error_message = "The freelancer did not connect a bank account or credit card"
      project.update(project_status: :error, error_message: error_message)
      return { message: error_message, status: 400 }
    end

    payment_amount = params[:payment_amount]
    total = (payment_amount * 100).round
    transfer = Admin::StripeService.create_transfer(total, user.freelancer_detail.connected_account_id)
    Admin::PaymentsService.create_payment(transfer, user)

    project.update(project_status: :active, error_message: nil)
    return { message: 'freelancer has been paid', status: 200 }

    rescue Stripe::StripeError => e
      error_message = e.error.message
      if e.error.code == 'balance_insufficient'
        error_message = 'Insufficient funds in Stripe account.'
      end
      project.update(project_status: :error, error_message: error_message)
      return { message: error_message, status: 400 }
  end

  def self.enable_automated_invoicing(project_id)
    project = Project.find(project_id)
    if project.invoicing_schedule != 'one_time'
      project.update_attribute(:automated_invoicing, true)
      week_amount = project.invoicing_schedule == 'weekly' ? 1 : 2
      invoicing_interval = week_amount.weeks
      Admin::GenerateInvoiceJob.set(wait: invoicing_interval).perform_later(project.id, invoicing_interval)
      return { message: "Enabled. First invoice will be generated on #{(Date.today + invoicing_interval).strftime("%B%e")}", status: 200 }
    else
      return { message: "Only weekly or bi-weekly projects able to use this feature", status: 400 }
    end
  end

  def self.disable_automated_invoicing(project_id)
    project = Project.find(project_id)
    project.update(automated_invoicing: false)
  end

  def self.deactivate_project(project_id)
    project = Project.find(project_id)
    project.project_status = 'inactive'
    project.save
  end

  private

  def self.approve_freelancer(freelancer_detail_id)
    freelancer_detail = FreelancerDetail.find(freelancer_detail_id)
    if freelancer_detail
      freelancer_detail.update(qualified: true)
    end
  end

end
