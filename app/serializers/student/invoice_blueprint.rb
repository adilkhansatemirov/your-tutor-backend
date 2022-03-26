class Student::InvoiceBlueprint < Blueprinter::Base
  identifier :id
  
  fields :invoice_date,
         :invoice_status,
         :project_id

  field :amount do |invoice|
    invoice.invoice_items.sum {|invoice_item| invoice_item.qty * invoice_item.price}
  end

  field :project do |invoice|
    {
      title: invoice.project.title,
      invoicing_schedule: invoice.project.invoicing_schedule,
      student_type_of_billing: invoice.project.student_type_of_billing,
      student_payment_amount: invoice.project.student_payment_amount,
      tutor_detail: {
        user: {
          first_name: invoice.project.tutor_detail.user.first_name,
          last_name: invoice.project.tutor_detail.user.last_name,
          email: invoice.project.tutor_detail.user.email
        }
      }
    }
  end

  view :extended do
    association :invoice_items, blueprint: InvoiceItemBlueprint
  end
end
