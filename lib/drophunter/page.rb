require "drophunter/savers/local"

module Drophunter
  class Page < Struct.new(:id)
    BASE_URL = "http://d.pr/i/"

    def save(something, saver)
      puts "Downloading #{url}"

      begin
        something.new(Nokogiri::HTML(open(url)), id).find_and_save(saver)
      rescue *error_messages.keys => error
        puts error_messages[error.class]
      end
    end

    private

    def error_messages
      {
        OpenURI::HTTPError => "#{id} doesn't exist on Droplr",
        RuntimeError => "#{id} caused an error (redirect?)",
        SocketError => "#{id} caused an error (redirect with missing page?)",
        Errno::ECONNRESET => "#{id} caused an error (and I have no idea why)",
        Errno::ETIMEDOUT => "#{id} caused an error (timed out)"
      }
    end

    def url
      BASE_URL + id
    end
  end
end
