module MicropostsHelper
  # 画像のExifから緯度経度を取得
  def get_exif(model)
    require 'exifr/jpeg'
    @exif = if Rails.env.production?
              EXIFR::JPEG.new(open(model.picture.url))
            else
              EXIFR::JPEG.new(Rails.root.to_s + "/public/#{model.picture.url}")
            end
    @lat = @exif.gps_latitude.to_f
    @lng = @exif.gps_longitude.to_f
  end

  def exif_valid?(model)
    return true if model.exif_is_valid == true && @exif.gps_latitude && @exif.gps_longitude

    false
  end
end
