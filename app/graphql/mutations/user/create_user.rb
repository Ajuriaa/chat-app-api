class Mutations::User::CreateUser < GraphQL::Schema::Mutation
  null true
  description 'Create a new user.'
  argument :user_attributes, Inputs::UserInputType, required: true
  payload_type Types::UserType

  def resolve(user_attributes:)
    user = user_attributes.to_kwargs

    raise GraphQL::ExecutionError, 'The Email has already been registered.' if User.exists?(email: user[:email])

    new_user = CreateNewUser.run(user_attributes: user)

    if new_user.valid?
      new_user.result
    else
      raise GraphQL::ExecutionError, new_user.errors[:user].first
    end
  end
end
