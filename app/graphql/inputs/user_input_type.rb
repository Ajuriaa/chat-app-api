class Inputs::UserInputType < Types::BaseInputObject
  description 'Attributes to create a user.'
  argument :email, String, 'user email', required: true
  argument :first_name, String, 'user first name', required: true
  argument :last_name, String, 'user last name', required: true
  argument :birthdate, String, 'user birth date', required: true
  argument :password, String, 'user password', required: true
  argument :username, String, 'username', required: true
end
