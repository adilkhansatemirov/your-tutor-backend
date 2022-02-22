task import_payments: :environment do
  all_transactions = []
  limit = 50
  transactions = Stripe::BalanceTransaction.list({ limit: limit, expand: ["data.source", "data.source.destination", "data.source.customer"] })
  transactions.each do |transaction|
    all_transactions.push(transaction)
  end
  while transactions.has_more
    transactions = Stripe::BalanceTransaction.list({ limit: limit, starting_after: all_transactions.last(), expand: ["data.source", "data.source.destination", "data.source.customer"] })
    transactions.each do |transaction|
      all_transactions.push(transaction)
    end
  end

  transfers = []
  charges = []

  all_transactions.each do |transaction|
    if transaction.reporting_category == "charge"
      charges.push(transaction)
    end

    if transaction.reporting_category == "transfer"
      transfers.push(transaction)
    end
  end

  transactions = []

  transfers.each do |transfer|
    user = User.where(role: "freelancer", email: transfer[:source][:destination][:email]).first
    if user
      Payment.create(
        payment_type: "payment",
        net_amount: transfer.net.to_f / 100.0,
        full_amount: transfer.amount.to_f / 100.0,
        stripe_fee: transfer.fee.to_f / 100.0,
        description: "Payment to #{user.first_name} #{user.last_name}",
        available_on: DateTime.strptime(transfer.available_on.to_s, "%s"),
        created_at: DateTime.strptime(transfer.created.to_s, "%s"),
        updated_at: DateTime.strptime(transfer.created.to_s, "%s"),
      )
    end
  end

  charges.each do |charge|
    user = User.where(role: "client", email: charge[:source][:customer][:email]).first
    if user
      Payment.create(
        payment_type: "charge",
        net_amount: charge.net.to_f / 100.0,
        full_amount: charge.amount.to_f / 100.0,
        stripe_fee: charge.fee.to_f / 100.0,
        description: "Payment from #{user.first_name} #{user.last_name}",
        available_on: DateTime.strptime(charge.available_on.to_s, "%s"),
        created_at: DateTime.strptime(charge.created.to_s, "%s"),
        updated_at: DateTime.strptime(charge.created.to_s, "%s"),
      )
    end
  end
end
