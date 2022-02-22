class UserBlueprint < Blueprinter::Base
  identifier :id
  
  fields :email,
         :first_name,
         :last_name,
         :image,
         :is_blocked,
         :role

  view :auth do
    field :token
  end

end
