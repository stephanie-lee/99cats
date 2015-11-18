class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: { in: %w(red brown black white),
    message: "%{color} is not a valid color" }
  validates :sex, inclusion: { in: %w(F M),
    message: "%{sex} is not a valid sex" }

    has_many :cat_rental_requests,
    dependent: :destroy,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id

  def age
    p birthdate = Cat.find_by(id).birth_date
    (Date.today - birthdate).to_i / 365
  end
end
