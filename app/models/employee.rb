class Employee < ActiveRecord::Base
  belongs_to :chair
  belongs_to :post
  belongs_to :degree
  belongs_to :academic_title
  has_many :points
  
  def fio
   [last_name, first_name, middle_name].compact.join(' ')
  end
  
  def rating(year)
    p = self.points.find_by_year(year)
    p.nil? ? 0 : p.rating
  end
  
  def head_rating(year)
    head_rating = 0.0
    self.head? ? head_rating = self.rating(year) + self.chair.rating(year)/2 : head_rating = 0.0
  end
  
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      employee = find(row["id"]) || new
      employee.attributes = row.to_hash.slice(:first_name, :middle_name, :last_name, :chair_id, :post_id, :degree_id, :academic_title_id, :head)
      employee.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".ods" then Roo::Openoffice.new(file.path, nil, :ignore)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
