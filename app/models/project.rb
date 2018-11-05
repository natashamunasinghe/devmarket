class Project < ApplicationRecord
  enum status: { open: 0, ongoing: 1, completed: 2 }

  belongs_to :user
  belongs_to :product

  attribute :status, default: 0

  has_many :bids, dependent: :destroy
  has_one :rating, dependent: :destroy
  has_many :images, as: :imageable
  # mount_uploader :project_image, ProjectImageUploader  # use Image model instead
end
