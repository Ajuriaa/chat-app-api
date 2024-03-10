class CreateNewUser < SimpleAction::Base
  params do
    param :user_attributes # {}
  end

  def execute
    existing_user = User.exists?(username: user_attributes[:username])
    return errors.add(:user, 'Username already taken.') if existing_user

    user_attributes[:first_password] = user_attributes[:password]
    user_attributes[:birthdate] = user_attributes[:birthdate].to_date
    create_user(user_attributes)
  end

  private

  def create_user(user_attributes)
    new_user = User.new(user_attributes)
    new_user.save!

    new_user
  end
end
