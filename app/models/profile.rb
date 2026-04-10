class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar_image

  validates :display_name, presence: true

  def portfolio_url
    website_url
  end

  def avatar_source
    return avatar_image if avatar_image.attached?
    return avatar_url if respond_to?(:avatar_url) && avatar_url.present?

    nil
  end
end