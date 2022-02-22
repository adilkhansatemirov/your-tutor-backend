require "csv"

task import_clients: :environment do
  # collect info about customers from stripe
  all_customers = []
  limit = 50
  customers = Stripe::Customer.list({ limit: limit })
  customers.each do |customer|
    all_customers.push(customer)
  end
  while customers.has_more
    customers = Stripe::Customer.list({ limit: limit, starting_after: all_customers.last() })
    customers.each do |customer|
      all_customers.push(customer)
    end
  end

  # go through each customer that needs to be imported
  CSV.foreach("clients.csv", headers: true) do |row|
    user = User.new(row.to_h)
    user.role = "client"
    user.password = "ghbdtn_vbh_9568"
    user.save

    client_detail = ClientDetail.new(:user_id => user.id)
    customer = all_customers.select {|customer| customer.email == user.email }[0]
    if customer
      client_detail.stripe_customer_id = customer.id
    end
    client_detail.save

    AllowedNotification.create(
      user_id: user.id,
      new_opportunity_available: false,
      project_bid_accepted: false,
      timesheet_rejected: false,
      new_timesheet_submitted: false,
      new_invoice_submitted: true,
    )
  end
end
