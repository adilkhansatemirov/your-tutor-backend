class Api::V1::Tutor::TutorSkillsController < ApplicationController
  before_action :authenticate_api_user!, :require_freelancer

  def index
    freelancer_skills = TutorSkill.where(user_id: current_api_user.id).joins(:skill).where({ skills: { category: params[:category] } })
    skills = Tutor::SkillBlueprint.render_as_hash(Skill.where(category: params[:category]))

    render json: {
      skills: skills.group_by { |skill| skill[:sub_category] },
      freelancer_skills: Tutor::TutorSkillBlueprint.render_as_hash(freelancer_skills),
    }
  end

  def all
    freelancer_skills = TutorSkill.where(user_id: current_api_user.id).includes(:skill)
    skills = Tutor::SkillBlueprint.render_as_hash(Skill.all)

    render json: {
      skills: Tutor::SkillsService.format_skills(skills),
      freelancer_skills: Tutor::FreelancerSkillBlueprint.render_as_hash(freelancer_skills),
    }
  end

  def update_skills
    Tutor::TutorSkillsService.create_multiple(update_freelancer_skills_params[:skills_to_create], current_api_user.id)
    Tutor::TutorSkillsService.delete_multiple(update_freelancer_skills_params[:skills_to_delete], current_api_user.id)
    render json: { message: "Skills updated" }, status: 200
  end

  private

  def update_freelancer_skills_params
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
