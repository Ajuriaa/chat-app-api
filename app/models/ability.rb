class Ability
  include CanCan::Ability

  def self.for(user)
    case user.exists?
    when true
      UserAbility.new(user)
    else
      raise 'You are not logged in!'
    end
  end

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    @user = user

    alias_action :create, :read, :update, :destroy, to: :crud
  end
end
