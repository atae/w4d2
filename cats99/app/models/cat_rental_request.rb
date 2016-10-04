class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: ["APPROVED","DENIED","PENDING"]}
  validate :overlapping_approved_request

  belongs_to :cat,
  primary_key: :id,
  foreign_key: :cat_id,
  class_name: :Cat

  def overlapping_request
    raise "End Date is before Start Date" if end_date - start_date < 0
     cat.rentals.any? do |other|
        (start_date - other.end_date) * (other.start_date - end_date) >= 0
      end
  end

  def overlapping_approved_request
    if overlapping_request == false
      status = "APPROVED"
    else
      status = "DENIED"
    end
  end




end
