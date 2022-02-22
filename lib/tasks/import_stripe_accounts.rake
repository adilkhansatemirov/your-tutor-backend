task import_stripe_accounts: :environment do
  all_accounts = []
  limit = 50
  accounts = Stripe::Account.list({ limit: limit })
  accounts.each do |account|
    all_accounts.push(account)
  end
  while accounts.has_more
    accounts = Stripe::Account.list({ limit: limit, starting_after: all_accounts.last() })
    accounts.each do |account|
      all_accounts.push(account)
    end
  end

  counter = 0
  all_accounts.each do |account|
    user = User.find_by(email: account.email)
    if user
      freelancer_detail = FreelancerDetail.find_by(user_id: user.id)
      if freelancer_detail
        freelancer_detail.connected_account_id = account.id
        freelancer_detail.save
        counter = counter + 1
      end
    end
  end

  puts "accounts connected: #{counter}"
end
