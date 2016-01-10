class Parrot < ActiveRecord::Base
  belongs_to :color
  has_parents sex_values: %w(male female)

  default_scope { order(created_at: :desc) }

  validates :color_id, presence: true
  validates :sex,      presence: true
  validates :age,      inclusion: { in: 0..240, message: 'Age must be between 0 and 240' }
  validates :tribal,   inclusion: [ true, false ]
  validate :both_parents_must_be_present
  validate :both_parents_must_exist

  def both_parents_must_be_present
    if mother_id && father_id.nil?
      errors.add(:father_id, 'must not be nil')
    elsif mother_id.nil? && father_id
      errors.add(:mother_id, 'must not be nil')
    end
  end

  def both_parents_must_exist
    if mother_id && Parrot.where(id: mother_id)[0].nil?
      errors.add(:mother_id, 'must be valid')
    elsif father_id && Parrot.where(id: father_id)[0].nil?
      errors.add(:father_id, 'must be valid')
    end
  end

  def color_hex
    color.hex_value
  end

  # Parrots shouldn't stay unnamed
  after_create do
    if name.nil?
      update_attribute :name, (case sex
                                when 'male'
                                  Forgery('name').male_first_name
                                else
                                  Forgery('name').female_first_name
                              end)
    end
  end
end
