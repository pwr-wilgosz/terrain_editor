class Point < ActiveRecord::Base
  belongs_to :map
  has_many :edges, as: :source, foreign_key: :source_id, dependent: :destroy
  has_many :edges, as: :target, foreign_key: :target_id, dependent: :destroy
end
