class Inputs::UserInputType < Types::BaseInputObject
  description 'Attributes to create a user.'
  argument :email, String, 'user email', required: false
  argument :first_name, String, 'user first name', required: true
  argument :last_name, String, 'user last name', required: true
  argument :gender, String, 'male or female', required: true
  argument :birthdate, String, 'user birth date', required: true
  argument :password, String, 'user password', required: true
end
