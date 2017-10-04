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
  process :adjuster_hashup


  def parse_to_array
    Rails.logger.info "self.file.file:#{self.file.file}"
    f = File.new( self.file.file )
    Rails.logger.info "The file is:#{f.path}"
    @xl_obj = MMA::Banks::WellsFargo::RateSheet::WellsFargoConformingPricing.new(f, 0 )
  rescue Exception => ex
    Rails.logger.error( "Exception within parse_to_array:#{ex.message}" )
    Rails.logger.error( ex.backtrace )
  end

  def do_hashup
    Rails.logger.info 'in do_hashup'
    @price_hash         = @xl_obj.hashup
    Rails.logger.info '@price_hash.keys'
    Rails.logger.info @price_hash.keys
    temp_hash           = { adjusters:{}, pricing:{} }
    temp_hash[:pricing] = @price_hash
    model.json          = temp_hash
    Rails.logger.info 'about to save model.json'
    model.save
  rescue Exception => ex
    Rails.logger.error( "Exception within do_hashup:#{ex.message}" )
    Rails.logger.error( ex.backtrace )
  end

  def adjuster_hashup
    Rails.logger.info 'in adjuster_hashup'
    Rails.logger.info "self.file.file:#{self.file.file}"
    f = File.new( self.file.file )
    Rails.logger.info "the file is:#{f.path}"
    adjuster_obj            = MMA::Banks::WellsFargo::RateSheet::WellsFargoConformingAdjusters.new( f )
    if model.json.nil?
      model.json = { pricing:{}, adjusters:{} }
    end
    model.json[:adjusters]  = adjuster_obj.hashup

    if model.json.is_a?(Hash) && model.json[:pricing].blank?
      if @price_hash.nil? && @xl_obj.nil?
        @xl_obj     = MMA::Banks::WellsFargo::RateSheet::WellsFargoConformingPricing.new( f )
        @price_hash = @xl_obj.hashup
      elsif @price_hash.nil?
        @price_hash = @xl_obj.hashup
      end
      model.json[:pricing]  = @price_hash.hashup
    end

    Rails.logger.info 'about to save model.json'
    model.save
  end
end
