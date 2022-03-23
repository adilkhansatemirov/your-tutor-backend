class Api::V1::Admin::FreelancerSkillsController < ApplicationController
  before_action :authenticate_api_user!, :require_admin

  # GET /admin/skills
  def show
    freelancer_skills = FreelancerSkill.where(user_id: params[:id]).includes(:skill)
    skills = Admin::SkillBlueprint.render_as_hash(Skill.all)

    render json: {
      skills: Admin::SkillsService.format_skills(skills),
      freelancer_skills: Admin::FreelancerSkillBlueprint.render_as_hash(freelancer_skills),
    }
  end

  # POST /admin/skills/upload_skills
  def update
    Admin::FreelancerSkillsService.create_multiple(update_params[:skills_to_create], params[:id])
    Admin::FreelancerSkillsService.delete_multiple(update_params[:skills_to_delete], params[:id])
    render json: { message: "Skills updated" }, status: 200
  end

  def update_params
    params.require(:skills_to_update).permit(
      skills_to_create: [
        :category,
        :checked,
        :id,
        :skill,
        :sub_category,
      ],
      skills_to_delete: [
        :category,
        :checked,
        :id,
        :skill,
        :sub_category,
      ],
    )
  end

end
