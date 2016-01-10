class Color < ActiveRecord::Base
  has_many :parrots

  validates :name,      presence: true, uniqueness: true
  validates :hex_value, presence: true
end
