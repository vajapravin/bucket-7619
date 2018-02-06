module Identifiable
  def self.included(base)
    base.has_one :uid, as: :identifiable, dependent: :destroy
    base.before_create :set_uid
    base.delegate :identifier, to: :uid

    base.scope :where_by_identifier, lambda { |identifier|
      joins(:uid).where(uids: {identifier: identifier})
    }
  end

  private

  def set_uid
    build_uid
  end
end