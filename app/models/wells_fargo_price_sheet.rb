class WellsFargoPriceSheet < ActiveRecord::Base
  attr_accessor :thefile, :name #:description
  mount_uploader :thefile, XlUploader

  def filename
    @thefile.split('/').last unless @thefile.nil?
  end
end
