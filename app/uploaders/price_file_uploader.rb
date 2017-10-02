require 'pp'

class PriceFileUploader < CarrierWave::Uploader::Base

  attr_accessor :xl_obj, :price_hash

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(xls xlsx)
  end

  process :parse_to_array
  process :do_hashup

  def parse_to_array
    Rails.logger.debug "self.file.file:#{self.file.file}"
    f = File.new( self.file.file )
    Rails.logger.debug "The file is:#{f.path}"
    @xl_obj = MMA::Banks::WellsFargo::RateSheet::WellsFargoConformingPricing.new(f, 0 )
  end

  def do_hashup
    Rails.logger.debug 'in do_hashup'
    @price_hash = @xl_obj.hashup
    Rails.logger.debug '@price_hash.keys'
    Rails.logger.debug @price_hash.keys
    model.json = @price_hash
    Rails.logger.debug 'about to save model.json'
    model.save
  end
end
