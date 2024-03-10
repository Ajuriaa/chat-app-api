class Ability
  include CanCan::Ability

  def self.for(user)
    raise 'You are not logged in!' if user.nil?

    UserAbility.new(user)
  end

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    @user = user

    alias_action :create, :read, :update, :destroy, to: :crud
  end
end
