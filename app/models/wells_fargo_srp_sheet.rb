class WellsFargoSrpSheet < ActiveRecord::Base
  attr_accessor :srp, :name #:description
  mount_uploader :srp, SrpUploader
  serialize :json

  def filename
    @srp.split('/').last unless @srp.nil?
  end
end
