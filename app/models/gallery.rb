class Gallery < ActiveRecord::Base
  attr_accessor :name
  has_many :paintings
  has_many :excel_files
  def gallery_name
    self[:name]
  end
end
