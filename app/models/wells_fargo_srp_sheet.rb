class WellsFargoSrpSheet < ActiveRecord::Base
  attr_accessor :thefile, :name #:description
  mount_uploader :thefile, XlUploader

  def filename
    self.thefile.split('/').last
  end
end
