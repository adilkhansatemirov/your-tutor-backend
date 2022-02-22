module Admin::PaymentsService

  def self.create_charge(invoice, user)
    Payment.create(
      payment_type: "charge",
      net_amount: invoice.charge.balance_transaction.net.to_f / 100.0,
      full_amount: invoice.charge.balance_transaction.amount.to_f / 100.0,
      stripe_fee: invoice.charge.balance_transaction.fee.to_f / 100.0,
      description: "Payment from #{user.first_name} #{user.last_name}",
      available_on: DateTime.strptime(invoice.charge.balance_transaction.available_on.to_s, "%s"),
    )
  end

  def self.create_payment(transfer, user)
    Payment.create(
      payment_type: "payment",
      net_amount: transfer.balance_transaction.net.to_f / 100.0,
      full_amount: transfer.balance_transaction.amount.to_f / 100.0,
      stripe_fee: transfer.balance_transaction.fee.to_f / 100.0,
      description: "Payment to #{user.first_name} #{user.last_name}",
      available_on: DateTime.strptime(transfer.balance_transaction.available_on.to_s, "%s"),
    )
  end
end
