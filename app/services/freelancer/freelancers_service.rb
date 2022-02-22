module Freelancer::FreelancersService

  def self.upload_resume(user_id, resume)
    freelancer_detail = FreelancerDetail.find_by(user_id: user_id)
    resume_uploaded = Cloudinary::Uploader.upload(resume, :use_filename => true, :unique_filename => false, :resource_type => :auto)
    freelancer_detail.update(
      resume_url: resume_uploaded["secure_url"],
      public_id: resume_uploaded["public_id"],
      file_format: resume_uploaded["format"],
      pages: resume_uploaded["pages"],
    )
  end

  def self.connect_stripe(user_id, code)
    user = User.find(user_id)
    response = Stripe::OAuth.token({
      grant_type: 'authorization_code',
      code: code,
    })
    user.freelancer_detail.update(connected_account_id: response.stripe_user_id)
  end

  def self.finish_all_steps(user_id)
    user = User.find(user_id)
    user.freelancer_detail.update(interview_scheduled: true)
  end

  def self.generate_express_dashboard_link(user_id)
    user = User.find(user_id)
    link = Stripe::Account.create_login_link(user.freelancer_detail.connected_account_id)
    link
  end

end
