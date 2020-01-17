module ApplicationHelper

    def full_title(page_title='')
        base_title='NateMate'
        if page_title.empty?
            base_title
        else
            page_title + ' | ' + base_title
        end
    end

    def get_exif
        require 'exifr/jpeg'
        exif = EXIFR::JPEG.new(self.file.file)
        @latitude = exif.GPSLatitude
        @longitude = exif.GPSLongitude
    end


    def resource_name
        :user
     end

     def resource
        @resource ||= User.new
     end

     def devise_mapping
        @devise_mapping ||= Devise.mappings[:user]
     end
end
