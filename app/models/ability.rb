class Ability
  include CanCan::Ability

  # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  def initialize(staff)
    @staff = staff
    send staff.role.to_sym
    can :manage, ActiveAdmin::Page, name: 'Dashboard'
  end

  def admin
    can :manage, :all
  end

  def general
  end

  def label
    can :manage, [Artist, Item]
    can :read, ActiveAdmin::Page, name: 'Stat'
    can [:read, :update], Staff, id: @staff.id
  end

  def guest
  end
end
