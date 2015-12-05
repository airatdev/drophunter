module Drophunter
  module Savers
    class Local
      def save(id, url)
        open("#{id}.png", "wb") do |file|
          file << open(url).read
        end
      end
    end
  end
end
