class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED),
    message: "%{status} is not a valid status" }
  validate :overlapping_approved_requests

  belongs_to :cat,
    class_name: "Cat",
    foreign_key: :cat_id,
    primary_key: :id

  def overlapping_requests
    CatRentalRequest
    .where("cat_id = ?", self.cat_id)
    .where("? > start_date AND ? < end_date", self.end_date, self.start_date)

  end

  def overlapping_approved_requests
    if overlapping_requests.where("status = 'APPROVED'")
      errors.add(:cat, "is already booked for that date/time")
    end
  end


end
