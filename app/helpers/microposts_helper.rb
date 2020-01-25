module MicropostsHelper

#画像のExifから緯度経度を取得
 def get_exif(model)
    require 'exifr/jpeg'
    if Rails.env == 'production'
      @exif = EXIFR::JPEG.new(open(model.picture.url))
    else
      @exif = EXIFR::JPEG.new(Rails.root.to_s+"/public/#{model.picture.url}")
    end
    @lat = @exif.gps_latitude.to_f
    @lng = @exif.gps_longitude.to_f
 end
end
