require "nokogiri"

module Drophunter
  class Drop < Struct.new(:id)
    BASE_URL = "http://d.pr/i/"

    def find
      url = BASE_URL + id

      puts "Downloading #{url}"

      begin
        page = Nokogiri::HTML(open(url))
      rescue OpenURI::HTTPError
        puts "#{id} doesn't exist on Droplr"
        return false
      rescue RuntimeError
        puts "#{id} caused an error (redirect?)"
        return false
      rescue SocketError
        puts "#{id} caused an error (redirect with missing page?)"
        return false
      rescue Errno::ECONNRESET
        puts "#{id} caused an error (and I have no idea why)"
        return false
      rescue Errno::ETIMEDOUT
        puts "#{id} caused an error (timed out)"
        return false
      end

      if page.at_css(".image img")
        puts "Something like image found for #{id}"

        if img = page.at_css("body.image-drop .image img")
          puts "#{id} is OK"
          image_url = img.attr("src")
        else
          puts "#{id} is not a Droplr image"
          return false
        end
      else
        puts "#{id} is not an image"
        return false
      end

      open("#{id}.png", "wb") do |file|
        file << open(image_url).read
      end
    end
  end
end
