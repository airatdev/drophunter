require "open-uri"
require "nokogiri"
require "drophunter/page"
require "drophunter/file_types/image"

module Drophunter
  class Runner
    ALLOWED_CHARS = [*"a".."z", *"A".."Z"]

    def self.run
      ALLOWED_CHARS.repeated_permutation(4).each do |id_as_array|
        Drophunter::Page.new(id_as_array.join).save(Drophunter::FileTypes::Image)
      end
    end
  end
end
