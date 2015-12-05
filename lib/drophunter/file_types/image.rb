module Drophunter
  module FileTypes
    class Image < Struct.new(:content, :id)
      def find_and_save(saver)
        if image_element
          puts "#{id} is OK"

          saver.save(id, image_element.attr("src"))
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
