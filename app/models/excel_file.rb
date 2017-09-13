class ExcelFile < ActiveRecord::Base
  attr_accessor :name, :xl
  mount_uploader :xl, XlUploader
end
