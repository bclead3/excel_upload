class ExcelFile < ActiveRecord::Base
  attr_accessor :gallery_id, :name, :xl
  belongs_to :gallery
  mount_uploader :xl, XlUploader
end
