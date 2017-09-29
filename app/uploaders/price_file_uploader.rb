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
    puts "self.file.file:#{self.file.file}"
    f = File.new( self.file.file )
    puts "The file is:#{f.path}"
    @xl_obj = MMA::Banks::WellsFargo::RateSheet::WellsFargoConformingPricing.new(f, 0 )
  end

  def do_hashup
    puts 'in do_hashup'
    @price_hash = @xl_obj.hashup
    pp @price_hash
    model.json = @price_hash
    model.save
  end
end
