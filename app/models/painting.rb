class Painting < ActiveRecord::Base
  attr_accessor :gallery_id, :name, :image, :remote_image_url, :xl
  belongs_to :gallery
  mount_uploader :image, ImageUploader
end
