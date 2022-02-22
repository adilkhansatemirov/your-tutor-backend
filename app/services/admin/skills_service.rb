module Admin::SkillsService

  def self.format_skills(skills)
    formatted_skills = {}
    skills.each do |skill|
      formatted_skills[skill[:category]] ||= {}
      formatted_skills[skill[:category]][skill[:sub_category]] ||= []

      formatted_skills[skill[:category]][skill[:sub_category]] << skill
    end
    formatted_skills
  end

end
