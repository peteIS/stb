class Item < ApplicationRecord
  mount_uploader :image, ImageUploader

  before_destroy :not_referenced_by_any_line_item
  has_many :line_items
  default_scope { where(active: true) }

  private

  def not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, "Line items present")
      throw :abort
    end
  end

end
