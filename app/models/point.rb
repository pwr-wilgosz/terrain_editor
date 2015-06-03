class Point < ActiveRecord::Base
  belongs_to :map
  has_many :edges, foreign_key: :source_id, dependent: :destroy
  has_many :edges, foreign_key: :target_id, dependent: :destroy
end
