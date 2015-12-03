module Drophunter
  module FileTypes
    class Image < Struct.new(:content, :id)
      def find_and_save
        if image_element
          puts "#{id} is OK"

          open("#{id}.png", "wb") do |file|
            file << open(image_element.attr("src")).read
          end
        else
          puts "#{id} is not a Droplr image"
        end
      end

      private

      def image_element
        @image_element ||= content.at_css("body.image-drop .image img")
      end
    end
  end
end
