class WellsFargoSrpSheet < ActiveRecord::Base
  attr_accessor :thefile, :name #:description
  mount_uploader :thefile, WellsFargoSrpUploader
  serialize :json

  def filename
    @srp.split('/').last unless @srp.nil?
  end
end
