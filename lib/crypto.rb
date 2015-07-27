module Crypto
  BUF_SIZE = 16384

  def self.encrypt(file)
    cipher = OpenSSL::Cipher::AES256.new :CBC
    cipher.encrypt

    key = Base64.urlsafe_encode64 cipher.random_key
    iv = Base64.urlsafe_encode64 cipher.random_iv

    tmp = Tempfile.new file.original_filename
    tmp.binmode
    while buf = file.read(BUF_SIZE)
      tmp << cipher.update(buf)
    end
    tmp << cipher.final
    tmp.flush
    tmp.rewind

    { key: key, iv: iv, file: tmp }
  end

  def self.decrypt(options)
    decipher = OpenSSL::Cipher::AES256.new :CBC
    decipher.decrypt

    decipher.key = Base64.urlsafe_decode64 options[:key]
    decipher.iv = Base64.urlsafe_decode64 options[:iv]

    file = options[:file]
    tmp = Tempfile.new file.original_filename
    tmp.binmode
    while buf = file.read(BUF_SIZE)
      tmp << decipher.update(buf)
    end
    tmp << decipher.final
    tmp.flush
    tmp.rewind

    tmp
  end

end
