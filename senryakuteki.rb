require 'MeCab'

module Senryakuteki
  def self.convert(text)
    result = ""
    node = MeCab::Tagger.new.parseToNode(text)

    while node do
      hinsi = node.feature.split(",").first

      if hinsi == "̾��" 
        case rand(100)
        when 0..30
          result << "��άŪ"
        when 0..60
          result << "��άŪ��"
        end
      end

      result << "#{node.surface}"
      node = node.next
    end

    result
  end
end
