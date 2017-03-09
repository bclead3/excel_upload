# from http://www.mccartie.com/2015/10/20/default-uuid's-in-rails.html
class EnableUuidExtension < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
  end
end
