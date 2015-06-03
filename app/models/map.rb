require 'roo'
class Map < ActiveRecord::Base
  belongs_to :user

  has_many :points, dependent: :destroy
  has_many :edges, dependent: :destroy

  attr_accessor :file

  validates :name, presence: true
  validates :file, presence: true, on: :create

  after_save :import

  def simplified_edges
    point_list = points.pluck(:id).sort
    edges.select(:source_id, :target_id).reduce([]) { |r, edge| r << [point_list.index(edge.source_id), point_list.index(edge.target_id) ] }
  end

  def next_map
    list = Map.all.pluck(:id).sort
    if id == list.last
      Map.find(list.first)
    elsif list.length == 2
      Map.find(list.last)
    else
      Map.find(list.index(id)+2)
    end
  end

  def prev_map
    list = Map.all.pluck(:id).sort
    if id == list.first
      Map.find(list.last)
    elsif list.length == 2
      Map.find(list.first)
    else
      Map.find(list.index(id))
    end
  end

  def import
    return if file.blank?
    self.points.destroy_all
    self.edges.destroy_all
    csv = Roo::Spreadsheet.open(file)
    sheet = csv.sheet(0)
    tmp = []
    sheet.each_with_index do |row, index|
      source = {}
      target = {}
      full_row = row.join(";").split(";")
      return if full_row.length != 6
      source[:x], source[:y], source[:z], target[:x], target[:y], target[:z] = full_row
      tmp << [source, target]
    end
    tmp_points = self.points.build(tmp.flatten.uniq)
    Point.import(tmp_points) && self.reload

    tmp_edges = tmp.reduce([]) do |r, edge|
      source = points.find_by(x: edge.first[:x], y: edge.first[:y], z: edge.first[:z]).id
      target = points.find_by(x: edge.last[:x], y: edge.last[:y], z: edge.last[:z]).id
      r << self.edges.build(source_id: source, target_id: target)
    end

    Edge.import(tmp_edges)
  end

end
