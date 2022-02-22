module Admin::FreelancersService

  def self.upload_resume(user_id, resume)
    freelancer_detail = FreelancerDetail.find_by(user_id: user_id)
    resume_uploaded = Cloudinary::Uploader.upload(resume, :use_filename => true, :unique_filename => false, :resource_type => :auto)
    freelancer_detail.update(
      resume_url: resume_uploaded["secure_url"],
      public_id: resume_uploaded["public_id"],
      file_format: resume_uploaded["format"],
      pages: resume_uploaded["pages"]
    )
  end

  def self.qualify_freelancer(user_id)
    user = User.find(user_id)
    user.freelancer_detail.update(qualified: true)
  end

  def self.delete_freelancer(user_id)
    freelancer = User.find(user_id)
    AllowedNotification.where(user_id: freelancer.id).destroy_all
    ProjectBid.where(user_id: freelancer.id).destroy_all
    Project.where(freelancer_detail_id: freelancer.freelancer_detail.id).update_all(project_status: :inactive)
    FreelancerDetail.where(user_id: freelancer.id).first.destroy
    freelancer.destroy
  end

end
