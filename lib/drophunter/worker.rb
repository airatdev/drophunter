require "open-uri"
require "nokogiri"
require "drophunter/page"
require "drophunter/file_types/image"

module Drophunter
  class Worker < Struct.new(:strategy)
    ALLOWED_CHARS = [*"a".."z", *"A".."Z"]

    def run
      send("#{strategy || :default}_strategy")
    end

    private

    def save_file(id)
      Drophunter::Page.new(id).save(Drophunter::FileTypes::Image)
    end

    def default_strategy
      ALLOWED_CHARS.repeated_permutation(4).each do |id_as_array|
        save_file(id_as_array.join)
      end
    end

    def random_strategy
      Enumerator.new do |enumerator|
        loop do
          enumerator.yield(4.times.map { ALLOWED_CHARS[Random.rand(0..ALLOWED_CHARS.length)] }.join)
        end
      end.each do |id|
        save_file(id)
      end
    end
  end
end
