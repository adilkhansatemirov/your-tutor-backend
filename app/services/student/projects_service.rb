module Student::ProjectsService

  def self.create_project(params, user)
    Project.create(
      title: params[:title],
      description: params[:description],
      project_duration: "",
      project_status: "assigning_freelancer",
      invoicing_schedule: "one_time",
      student_type_of_billing: "custom_type",
      student_payment_amount: params[:student_payment_amount],
      freelancer_payment_amount: 0,
      freelancer_detail_id: nil,
      student_detail_id: user.student_detail.id,
      # is_created_by_client: true,
    )
  end

end
