# require 'faker'
#
# admin = User.create(
#   email: "admin@gmail.com",
#   first_name: "Admin",
#   last_name: "Admin",
#   password: "password",
#   role: "admin"
# )
# AllowedNotification.create(
#   user_id: admin.id,
#   new_opportunity_available: false,
#   project_bid_accepted: false,
#   timesheet_rejected: false,
#   new_timesheet_submitted: true,
#   new_invoice_submitted: false,
# )
#
# (1..10).each do |i|
#   puts("Freelancer", i)
#   user = User.create(
#     email: Faker::Internet.email,
#     role: 'freelancer',
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     password: "password"
#   )
#   FreelancerDetail.create(user_id: user.id, sign_up_code: "CODE", sign_up_code_entered: true)
#   AllowedNotification.create(
#     user_id: user.id,
#     new_opportunity_available: true,
#     project_bid_accepted: true,
#     timesheet_rejected: true,
#     new_timesheet_submitted: false,
#     new_invoice_submitted: false,
#   )
# end
#
# (1..10).each do |i|
#   puts("Client", i)
#   user = User.create(
#     email: Faker::Internet.email,
#     role: 'client',
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     password: "password"
#   )
#   ClientDetail.create(user_id: user.id, company_name: Faker::Company.name)
#   AllowedNotification.create(
#     user_id: user.id,
#     new_opportunity_available: false,
#     project_bid_accepted: false,
#     timesheet_rejected: false,
#     new_timesheet_submitted: false,
#     new_invoice_submitted: true,
#   )
# end
#
# (1..20).each do |i|
#   puts("Project", i)
#   Project.create({
#     title: Faker::Game.title,
#     description: Faker::Lorem.paragraph,
#     project_duration: ['12 Hours', '22 Hours', '2 weeks'].sample,
#     project_status: %w[active inactive].sample,
#     invoicing_schedule: %w[one_time weekly bi_weekly].sample,
#     client_type_of_billing: %w[fixed_fee hourly_rate].sample,
#     freelancer_type_of_billing: %w[fixed_fee hourly_rate].sample,
#     client_payment_amount: "15",
#     freelancer_payment_amount: "13",
#     freelancer_detail_id: FreelancerDetail.pluck(:id).sample,
#     client_detail_id: ClientDetail.pluck(:id).sample
#   })
# end
#
#
#
# # admins = User.where("role = 0")
# # admins.each do |admin|
# #   AllowedNotification.create(
# #     user_id: admin.id,
# #     new_opportunity_available: false,
# #     project_bid_accepted: false,
# #     timesheet_rejected: false,
# #     new_timesheet_submitted: true,
# #     new_invoice_submitted: false,
# #   )
# # end
#
# # freelancers = User.where("role = 1")
# # freelancers.each do |freelancer|
# #   AllowedNotification.create(
# #     user_id: freelancer.id,
# #     new_opportunity_available: true,
# #     project_bid_accepted: true,
# #     timesheet_rejected: true,
# #     new_timesheet_submitted: false,
# #     new_invoice_submitted: false,
# #   )
# # end
#
# # clients = User.where("role = 2")
# # clients.each do |client|
# #   AllowedNotification.create(
# #     user_id: client.id,
# #     new_opportunity_available: false,
# #     project_bid_accepted: false,
# #     timesheet_rejected: false,
# #     new_timesheet_submitted: false,
# #     new_invoice_submitted: true,
# #   )
# # end
#
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Preparation of Form 1040",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Itemized deductions",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Interest & Dividends",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Profit or loss from business",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Capital gains and losses",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Rental real estate, and pass through income",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Profit or loss from farming",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "IRA's, Pensions, and Annuities",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Health Savings Accounts",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Health Savings Accounts",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Self-employed retirement plans",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "IRA Deductions",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Code Section 199A",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Form 4029 Exempt",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Form 4361 Exempt",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Fin 114",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Deprecation - Federal",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Deprecation - State",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Residential Energy Credits",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Household Employment Taxes",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Tax on qualified retirement plans",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Net Investment Taxes",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Foreign Tax Credit",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Credit for Child Care Expenses",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Educations Credits",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Retirement Credits",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Residential Energy Credits",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Earned Income Credit",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Fuel Tax Credits",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Other Tax Credits",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Change in accounting methods",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Sale of business property",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Passive Activities",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "At risk limitations",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Installment sales",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Like kind exchanges",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1040",
#   skill: "Extensions",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Preparation of form 1065",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Cash and bank reconciliations",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Accounts receivable",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Inventory and burden calculations",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Prepaid expenses",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Other assets",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Partner loans",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Fixed assets and depreciation",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Land",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Accounts payable",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Accrued expenses",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Loans",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Partners Equity",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Sales to sales tax reports",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Costs of Sales",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Operating expenses",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Payroll",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Basis calculation",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Trial balance and journal entries",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Schedules M-1 and M-2",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Partnership and LLC tax law",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "1099's",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Ordinary business income",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Rental income",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Guaranteed payments",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Investment income",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Royalties",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Gains and losses",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Deprecation - Federal",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1065",
#   skill: "Deprecation - State",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Preparation of form 1120",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Preparation of form 1120S",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Cash and bank reconciliations",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Accounts Receivable",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Inventory, burden rates and Unicap",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Prepaid expenses",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Other assets",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Shareholder loans",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Fixed assets and depreciation",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Land",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Accounts payable",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Accrued expenses",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Debt",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Capital Stock",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Additional Paid in Capital",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Retained earnings",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Sales to sales tax reports",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Costs of Sales",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Operating expenses",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Payroll",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Shareholder basis calculations",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Basis of Accounting - Cash",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Basis of Accounting - Accrual",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Trial balance and journal entries",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Schedules M-1 and M-2 Calculations",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Corporate tax law",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "S Corporation Elections Needed",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "1099's - Prepared",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "1099's - Need prepared",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "1099's - Need prepared but was not",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Ordinary business income",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Rental income",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Related party transactions",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Investment income",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Royalties",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Gains and losses",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Deprecation - Federal",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Deprecation - State",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Passive activities",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Foreign transactions",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1120 & 1120S",
#   skill: "Extensions",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "990",
#   skill: "Preparation of Form 990",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "990",
#   skill: "Preparation of Form 990T",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "990",
#   skill: "Non-profit tax law",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "990",
#   skill: "Non-profit tax elections",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "990",
#   skill: "Elections - Form 1023",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "990",
#   skill: "Elections - Form 1024",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1041",
#   skill: "Preparation of form 1041",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1041",
#   skill: "Trust tax law",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "1041",
#   skill: "Fiduciary tax law",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "State Tax Returns",
#   skill: "State Tax Returns",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "Gift Taxes",
#   skill: "Preparation of form 709",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "Gift Taxes",
#   skill: "Gift Tax laws",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "Estate Taxes",
#   skill: "Preparation of form 706",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "Estate Taxes",
#   skill: "Estate Tax Laws",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "Payroll",
#   skill: "State registration forms",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "Payroll",
#   skill: "Federal Forms - 940",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "Payroll",
#   skill: "Federal Forms - 941",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "Payroll",
#   skill: "Federal Forms - 943",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "Payroll",
#   skill: "Federal Forms - 944",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "Payroll",
#   skill: "State Unemployment forms",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "Payroll",
#   skill: "Localities",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "Payroll",
#   skill: "LST",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "Payroll",
#   skill: "Payroll quarterlies",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "Payroll",
#   skill: "W-2's",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "Payroll",
#   skill: "1099s",
# )
# Skill.create(
#   category: "Tax",
#   sub_category: "Sales Tax",
#   skill: "Sales Tax",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Cash and bank reconciliations",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Accounts receivable",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Inventory and burden calculations",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Prepaid expenses",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Other assets",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Partner loans",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Fixed assets and depreciation",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Land",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Accounts payables",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Accrued expenses",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Loans",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Partners Equity",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Sales to sales tax reports",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Costs of Sales",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Operating expenses",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Payroll",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Trial balance and journal entries",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Quality control documents",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Report preparation",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Financial statement preparation",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Business Type - Partnership",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Business Type - LLC",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Business Type - S Corporations",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Business Type - C Corporations",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Business Type - Sole proprietorship",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Business Type - Non profits",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "Compilations",
#   skill: "Business Type - Governmental",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Petty Cash",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Cash, bank reconciliations, bank confirmations, bank cut-off statements",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Aging accounts receivable and confirmations",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Inventory and burden calculations and schedules",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Prepaid expense documentation",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Other assets",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Deferred tax assets and liabilities",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Notes receivable and confirmations",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Fixed assets and depreciation",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Land",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Aging accounts payable",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Accrued expenses",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Short and long term debt testing and confirmations",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Equity",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Sales",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Costs of Sales",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Operating expenses",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Payroll",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Professional fees",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Repairs and Maintenance",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Travel and Entertainment",
# )
# Skill.create(
#   category: "Accounting",
#   sub_category: "General",
#   skill: "Trial balance and journal entries",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Planning - Quality Control documentation",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Planning - Engagement letter",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Planning - Engagement Acceptance and Continuation Form",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Planning - Understanding the Entity and Identifying Risks",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Planning - Risk Assessment Summary for Relevant Audit Areas",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Planning - Preliminary analytics",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Planning - Financial Statement Materiality",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Planning - Internal control",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Planning - Audit objectives and design",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Planning - General Planning Procedures",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Planning - Confirmations and Correspondence Control",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Planning - Engagement Independence Compliance and Documentation Form",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Planning - Engagement Team Discussion",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Planning - Significant Estimate Checklist",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Fraud Risks",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Sampling Planning and Evaluation",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Tests of Controls Sampling Planning and Evaluation",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Audit program checklists based on audit design",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Account testing, verification, and documentation",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Fraud questionnaire",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Perform substantive and control testing",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Perform analytical procedures – final analytics and ratio analysis",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Complete walk-through documentations",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Fieldwork - Legal letters",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Review - Audit Difference Evaluations",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Review - Disclosure Requirements",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Review - Supervision Review and Approval",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Review - Review and approve of audit documentation",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Review - Perform engagement quality control review",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Review - Complete disclosure requirements and checklist",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Audit Opinion",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Financial statement preparation",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Finalize - Report findings to appropriate client personnel",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Finalize - Management representation letter",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Finalize - Communication of Significant Deficiencies",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Business Type - Partnership",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Business Type - LLC",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Business Type - S Corporations",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Business Type - C Corporations",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Business Type - Sole proprietorship",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Business Type - Non profits",
# )
# Skill.create(
#   category: "Audits",
#   sub_category: "General",
#   skill: "Business Type - Governmental",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "Business write up",
#   skill: "Cash and bank reconciliations",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "Business write up",
#   skill: "Accounts receivable",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "Business write up",
#   skill: "Inventory and burden calculations",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "Business write up",
#   skill: "Prepaid expenses",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "Business write up",
#   skill: "Other assets",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "Business write up",
#   skill: "Deferred taxes",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "Business write up",
#   skill: "Notes receivable",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "Business write up",
#   skill: "Fixed assets",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "Business write up",
#   skill: "Land",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "Business write up",
#   skill: "Accounts payable",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "Business write up",
#   skill: "Accrued expenses",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "Business write up",
#   skill: "Short and long term debt",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "Business write up",
#   skill: "Equity",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "Business write up",
#   skill: "Sales",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "Business write up",
#   skill: "Costs of Sales",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "Business write up",
#   skill: "Operating expenses",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "Business write up",
#   skill: "Payroll",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "General",
#   skill: "Data Entry",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "General",
#   skill: "Account analysis",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "General",
#   skill: "Payroll and payroll taxes",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "General",
#   skill: "Sales tax",
# )
# Skill.create(
#   category: "Bookkeeping",
#   sub_category: "General",
#   skill: "Depreciation",
# )
#
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "QuickBooks",
#   skill: "Desktop",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "QuickBooks",
#   skill: "Online",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "General",
#   skill: "Xero Accounting Software",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "Sage 50 (Peachtree)",
#   skill: "Sage 50 Cloudaccounting",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "Sage 50 (Peachtree)",
#   skill: "Sage 50 Accounting",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "General",
#   skill: "JobBOSS Shop Management Solutions",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "General",
#   skill: "M1 ERP Software",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "General",
#   skill: "E2 Shop System",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "General",
#   skill: "FreshBooks",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "General",
#   skill: "Zoho Books",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "General",
#   skill: "Wave Accounting",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "General",
#   skill: "FreeAgent",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "General",
#   skill: "IQMS Manufacturing Software",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "General",
#   skill: "Foundation Software",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "General",
#   skill: "SageOne",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "General",
#   skill: "BillQuick",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "General",
#   skill: "Accounting Power",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "General",
#   skill: "NetClientCS",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "Tax Software",
#   skill: "UltraTax",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "Tax Software",
#   skill: "CCH ProSystems FX",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "Tax Software",
#   skill: "CCH Axcess",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "Tax Software",
#   skill: "Lacerte",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "Tax Software",
#   skill: "Drake",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "Tax Software",
#   skill: "Tax Act",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "Tax Software",
#   skill: "ProSeries",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "Tax Software",
#   skill: "ProConnect",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "Tax Software",
#   skill: "Tax Slayer",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "Tax Software",
#   skill: "Taxwise",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "Tax Software",
#   skill: "ATX",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "Tax Software",
#   skill: "GoSystem Tax",
# )
# Skill.create(
#   category: "Accounting Software",
#   sub_category: "Tax Software",
#   skill: "Tax Wise",
# )
