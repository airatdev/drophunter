module Drophunter
  module FileTypes
    class Image < Struct.new(:content, :id)
      def find_and_save
        if content.at_css(".image img")
          puts "Something like image found for #{id}"

          if img = content.at_css("body.image-drop .image img")
            puts "#{id} is OK"

            open("#{id}.png", "wb") do |file|
              file << open(img.attr("src")).read
            end
          else
            puts "#{id} is not a Droplr image"
          end
        else
          puts "#{id} is not an image"
        end
      end
    end
  end
end
