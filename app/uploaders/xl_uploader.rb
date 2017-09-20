class XlUploader < CarrierWave::Uploader::Base

  attr_accessor :xl_obj

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :parse_to_array
  process :import_into_loans_table

  def parse_to_array
    #puts 'within parse_to_array'
    #puts "About to load Excel file #{self.inspect}"
    #puts "file:#{self.file.file}"
    f = self.file.file
    @xl_obj = MMA::Excel::LoadExcel.new( f )
  end

  def import_into_loans_table
    #puts 'within import_indo_loans_table'
    #puts "About to delete #{MMA::Loan.count} existing loan rows"
    count = MMA::Loan.delete_all
    #puts "#{count} loan records deleted"
    #puts "The data sheet contains #{@xl_obj.row_arr.count} rows"
    MMA::Excel::ParseExcel.process_array( @xl_obj.row_arr )
  end
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end
  def extension_whitelist
    %w(xls xlsx)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
