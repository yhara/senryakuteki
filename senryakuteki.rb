require 'MeCab'

module Senryakuteki
  def self.convert(text)
    result = ""
    node = MeCab::Tagger.new.parseToNode(text)

    while node do
      hinsi = node.feature.split(",").first

      if hinsi == "Ì¾»ì" 
        case rand(100)
        when 0..30
          result << "ÀïÎ¬Åª"
        when 0..60
          result << "ÀïÎ¬Åª¤Ê"
        end
      end

      result << "#{node.surface}"
      node = node.next
    end

    result
  end
end
