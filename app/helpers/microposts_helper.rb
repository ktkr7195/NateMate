module MicropostsHelper

  #
  # 画像のExifから緯度経度を取得する
  # @param [Array] exif 画像のexif情報
  # @param [Float] lat, lng exif情報から取得し、GoogleMapAPIで扱えるfloat型に変換した緯度経度
  #
  def get_exif(model)
    require 'exifr/jpeg'
    @exif = if Rails.env.production?
              EXIFR::JPEG.new(open(model.picture.url))
            else
              EXIFR::JPEG.new(Rails.root.to_s + "/public/#{model.picture.url}")
            end
    @lat = @exif.gps_latitude.to_f
    @lng = @exif.gps_longitude.to_f

  rescue EXIFR::MalformedImage, EXIFR::MalformedJPEG
  end

  #
  # 投稿のexif情報アクセスが許可されており、有効な緯度経度を保持しているか判別する
  #
  def exif_valid?(model)
    return true if model.exif_is_valid == true && model.latitude.present? && model.longitude.present? \
                                               && model.latitude != 0.0 && model.longitude != 0.0

    false
  end

  #
  # 投稿に住所が入力されているか、入力された住所からgeocodingした有効な緯度経度を保持しているか判別する
  #
  def address_valid?(model)
    return true if model.address && model.latitude.present? && model.longitude.present? \
                                 && model.latitude != 0.0 && model.longitude != 0.0

    false
  end
end
