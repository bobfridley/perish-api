require 'crypto'

class Perishable < ActiveRecord::Base
  MAX_FILE_SIZE_MB = ENV.fetch('MAX_FILE_SIZE_MB', 200).to_f

  def self.paperclip_options
    options = {
      styles: { original: {} },
      processors: [:encrypt],
      url: '/system/:class/:attachment/:digest/:filename'
    }
    options[:path] = '/:class/:attachment/:digest/:filename' if Rails.env.produciton?
    options
  end

  has_attached_file :document, paperclip_options

  validates_attachment :document, presence: true, size: { less_than: MAX_FILE_SIZE_MB.megabytes }
  do_not_validate_attachment_file_type :document
  validate :server_must_have_space

  before_post_process :generate_digest

  validates :digest, presence: true, uniqueness: true
  validates :salt, presence: true

  attr_accessor :key, :iv

  def get_document(params)
    return nil unless params.include?(:key) && params.include?(:iv)

    begin
      tmp = Crypto::decrypt params.merge(file: Paperclip.io_adapters.for(document))
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

  def server_must_have_space
    errors.add(:document_file_size, 'server is full') if Perishable.sum(:document_file_size) + document_file_size > ENV.fetch('SERVER_STORAGE_SIZE_GB', 4).to_f.gigabytes
  end

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
