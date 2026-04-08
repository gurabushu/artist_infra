class Project < ApplicationRecord
  belongs_to :user

  has_many :job_applications, dependent: :destroy
  has_many :conversations, dependent: :destroy
  has_many :scouts, dependent: :destroy

  has_one :contract, dependent: :destroy

  enum :project_type, {
    one_time: 0,
    recurring: 1
  }, prefix: true

  enum :recruitment_type, {
    public_open: 0,
    scout_only: 1
  }, prefix: true

  enum :status, {
    draft: 0,
    open: 1,
    closed: 2,
    in_progress: 3,
    completed: 4
  }, prefix: true

  validates :title, presence: true
  validates :description, presence: true
end