class SrpUploader < CarrierWave::Uploader::Base

  attr_accessor :xl_obj, :srp_hash
  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(xls xlsx)
  end

  #process :parse_to_srp_conv
  #process :do_first_hashup

  def parse_to_srp_conv
    Rails.logger.info "self.file.file:#{self.file.file}"
    f = File.new( self.file.file )
    Rails.logger.info "The file is:#{f.path}"
    @xl_obj = MMA::Banks::WellsFargo::SrpAdjusters::WellsFargoSrpConvFullGrid.new(f, 0 )
    Rails.logger.info "@xl_obj is:#{@xl_obj.inspect}"
  rescue Exception => ex
    Rails.logger.error( "Exception within parse_to_srp_conv:#{ex.message}" )
    Rails.logger.error( ex.backtrace )
  end

  def do_first_hashup
    Rails.logger.info 'in do_hashup'
    @srp_hash  = @xl_obj.hashup
    Rails.logger.info "@price_hash.keys:#{@srp_hash.keys}"
    model.json = @srp_hash
    Rails.logger.info 'about to save model.json'
    model.save
  rescue Exception => ex
    Rails.logger.error( "Exception within do_first_hashup:#{ex.message}" )
    Rails.logger.error( ex.backtrace )
  end
end
