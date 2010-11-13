module LibKanji

  #
  # Methods for working with Japanese sentences.
  #
  module Sentence

    #
    # Parses a Japanese sentence into words.
    #
    def self.parse(sentence)
      list_of_words_in_sentence = []

      start = 0

      while start < sentence.length

        @words_from_dictionary = nil
        @matched_part_from_text = nil

        for finish in (start..sentence.length-1)
          lookup sentence[start..finish]
        end

        if @words_from_dictionary
          start += @matched_part_from_text.length - 1
        end

        key_to_add = @matched_part_from_text || sentence[start..start]
        
        list_of_words_in_sentence << SentenceWord.new(key_to_add, @words_from_dictionary)

        start += 1
      end
      return list_of_words_in_sentence
    end
    
    private
    
    def self.lookup(part)
      if Dictionary.has_word? part
        @words_from_dictionary = Dictionary.search(part)
        @matched_part_from_text = part
      end      
    end

  end
end
