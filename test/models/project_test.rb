require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @project = Project.new(
        title: "Title",
        description: "description",
        project_duration: "2 Hours",
        project_status: "active",
        invoicing_schedule: "one_time",
        client_type_of_billing: "custom_type",
        client_payment_amount: 12,
        freelancer_payment_amount: 12,
        freelancer_detail_id: freelancer_details(:one),
        client_detail: client_details(:one),
    )
  end

  test 'valid project' do
    assert @project.valid?
  end

  test 'invalid project' do
    project = Project.new
    assert_not project.valid?
  end
end
