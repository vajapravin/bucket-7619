# == Schema Information
#
# Table name: statements
#
#  id         :integer          not null, primary key
#  start_date :date
#  end_date   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Statement < ApplicationRecord
  has_one :activity, as: :invocation
end
