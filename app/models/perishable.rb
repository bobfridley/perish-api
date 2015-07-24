require 'crypto'

class Perishable < ActiveRecord::Base
  has_attached_file :document, styles: { original: {} }, processors: [:encrypt]

  validates_attachment :document, presence: true, size: { less_than: 100.megabytes }
  do_not_validate_attachment_file_type :document

  before_post_process :generate_digest

  attr_accessor :key, :iv

  def get_document(params)
    return nil unless params.include?(:key) && params.include?(:iv)

    begin
      tmp = Crypto::decrypt params.merge(file: File.new(document.path))
      if calculate_digest(tmp.path) == digest
        tmp
      else
        nil
      end
    rescue OpenSSL::Cipher::CipherError
      nil
    end
  end

  private

  def generate_digest
    self.salt = SecureRandom.hex
    self.digest = calculate_digest document.queued_for_write[:original].path
  end

  def calculate_digest(path)
    sha256 = Digest::SHA256.file path
    sha256.update salt
    sha256.hexdigest
  end
end
