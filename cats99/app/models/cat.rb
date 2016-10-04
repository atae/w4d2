class Cat < ActiveRecord::Base

  def self.colors
    ['brown','black','gray','orange','white','multi-color']
  end
  validates :name, presence: true, uniqueness: true
  validates :birth_date, presence: true
  validates :color, inclusion:{ in: ['brown','black','gray','orange','white','multi-color']}
  validates :sex, inclusion: { in: ['M','F','m','f']}

  has_many :rentals,
  primary_key: :id,
  foreign_key: :cat_id,
  class_name: :CatRentalRequest,
  dependent: :destroy

  def age
    dob = birth_date
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end
