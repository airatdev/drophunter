module Drophunter
  class Page < Struct.new(:id)
    BASE_URL = "http://d.pr/i/"

    def save(something)
      puts "Downloading #{url}"

      begin
        something.new(Nokogiri::HTML(open(url)), id).find_and_save
      rescue OpenURI::HTTPError
        puts "#{id} doesn't exist on Droplr"
      rescue RuntimeError
        puts "#{id} caused an error (redirect?)"
      rescue SocketError
        puts "#{id} caused an error (redirect with missing page?)"
      rescue Errno::ECONNRESET
        puts "#{id} caused an error (and I have no idea why)"
      rescue Errno::ETIMEDOUT
        puts "#{id} caused an error (timed out)"
      end
    end

    private

    def url
      BASE_URL + id
    end
  end
end
