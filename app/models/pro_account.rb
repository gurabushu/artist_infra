class ProAccount < ApplicationRecord
  belongs_to :user

  enum :status, { pending: 0, approved: 1, rejected: 2, suspended: 3 }, prefix: true


end