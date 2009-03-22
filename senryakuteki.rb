require 'MeCab'
require 'kconv'

module MeCab
  class Node
    def features
      self.feature.split(",")
    end

    def hinsi
      features[0]
    end

    def sub
      features[1]
    end

    def meisi?
      hinsi == "Ì¾»ì" or (hinsi == "ÀÜÆ¬»ì" and sub == "Ì¾»ìÀÜÂ³")
    end

    def prev_meisi?
      self.prev and (self.prev.meisi? or
                     self.prev.sub == "Ì¾»ìÀÜÂ³")
    end

    def next_dousi?
      return false unless self.meisi?

      node = self
      while node
        case
        when %w(Æ°»ì ½õÆ°»ì).include?(node.hinsi)
          return true
        when node.meisi?
          node = node.next
        else
          return false
        end
      end
      return false
    end

    NG_SUB = %w(¿ô Èó¼«Î© ÂåÌ¾»ì Éû»ì²ÄÇ½ ·ÁÍÆÆ°»ì¸ì´´) 
    def strategable?
      meisi? and 
      (not NG_SUB.include?(sub)) and
      (not prev_meisi?)
    end
  end
end

module Senryakuteki
  def self.convert(text)
    result = ""
    node = MeCab::Tagger.new.parseToNode(text)

    while node do
      if node.strategable?
        if node.next and node.next_dousi?
          result << "ÀïÎ¬Åª¤Ë" if rand(100) < 50
        else
          case rand(100)
          when 0..30
            result << "ÀïÎ¬Åª"
          when 0..60
            result << "ÀïÎ¬Åª¤Ê"
          end
        end
      end

      result << "#{node.surface}"

      node = node.next
    end

    result
  end
end
