class WellsFargoPriceSheet < ActiveRecord::Base
  attr_accessor :thefile, :name #:description
  mount_uploader :thefile, PriceFileUploader
  serialize :json

  def filename
    @thefile.split('/').last unless @thefile.nil?
  end

  def process
    file_path = this.thefile.path
    puts "The file path is:#{file_path}"
  end
end
