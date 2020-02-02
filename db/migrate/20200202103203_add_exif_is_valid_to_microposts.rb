class AddExifIsValidToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :exif_is_valid, :boolean, :null => false, :default => true
  end
end
