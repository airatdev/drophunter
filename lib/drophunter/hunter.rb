require 'open-uri'
require "drophunter/drop"

module Drophunter
  class Hunter
    ALLOWED_CHARS = [*'a'..'z', *'A'..'Z']

    def self.run
      ALLOWED_CHARS.repeated_permutation(4).each do |generated_droplr_id|
        Drop.new(generated_droplr_id.join).find
      end
    end
  end
end
