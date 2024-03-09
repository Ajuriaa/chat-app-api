class UserAbility < Ability
  def initialize(user)
    super(user)

    can %i[read update], User, id: user.id
  end
end
