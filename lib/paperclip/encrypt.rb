require 'crypto'

module Paperclip
  class Encrypt < Processor

    def self.make(file, options = {}, attachment = nil)
      result = Crypto::encrypt(file)
      attachment.instance.key = result[:key]
      attachment.instance.iv = result[:iv]
      result[:file]
    end

  end
end
