class ExcelFile < ActiveRecord::Base
  attr_accessor :name, :xl
  mount_uploader :xl, XlUploader
  #serialize :json

  def filename
    @xl.split('/').last unless @xl.nil?
  end

end
