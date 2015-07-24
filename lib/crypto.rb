module Crypto

  def self.encrypt(file)
    cipher = OpenSSL::Cipher::AES256.new :CBC
    cipher.encrypt

    key = bin_to_hex cipher.random_key
    iv = bin_to_hex cipher.random_iv

    tmp = Tempfile.new file.original_filename
    tmp.binmode
    while buf = file.read(16384)
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

    decipher.key = hex_to_bin options[:key]
    decipher.iv = hex_to_bin options[:iv]

    file = options[:file]
    tmp = Tempfile.new File.basename(file)
    tmp.binmode
    while buf = file.read(16384)
      tmp << decipher.update(buf)
    end
    tmp << decipher.final
    tmp.flush
    tmp.rewind

    tmp
  end

  private

  def self.bin_to_hex(s)
    s.each_byte.map { |b| b.to_s(16).rjust(2, '0') }.join
  end

  def self.hex_to_bin(s)
    s.scan(/../).map { |x| x.hex.chr }.join
  end

end
