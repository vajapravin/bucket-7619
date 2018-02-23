# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  profile_id             :integer
#  amount                 :float            default(0.0)
#  ancestry               :string
#  active                 :boolean          default(FALSE)
#

class User < ApplicationRecord
  rolify
  has_ancestry
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :invitable
  include Identifiable, UserHelper
  after_create :assign_default_role
  validate :ancestor_role

  alias customers children

  TOKEN_HEADER = 'Ally-Auth-Token'

  belongs_to :profile, optional: true
  accepts_nested_attributes_for :profile

  has_many :activities
  accepts_nested_attributes_for :activities
  accepts_nested_attributes_for :roles, allow_destroy: true

  has_many :deposit_activities, -> { order 'id' }, through: :activities, source: 'invocation', source_type: 'Deposit'
  has_many :withdraw_activities, -> { order 'id' }, through: :activities, source: 'invocation', source_type: 'Withdraw'
  has_many :statement_activities, -> { order 'id' }, through: :activities, source: 'invocation', source_type: 'Statement'

  private

  def assign_default_role
    self.add_role(:customer) if self.roles.blank?
  end

  def ancestor_role
    assigned_roles = roles.pluck(:name)
    if assigned_roles.include?('admin') && parent.has_role?('manager')
      errors.add(:base, I18n.t('role.access_denied'))
    end
  end
end
