class Perishable < ActiveRecord::Base
  has_attached_file :document, styles: { original: {} }, processors: [:encrypt]

  validates_attachment :document, presence: true, size: { less_than: 100.megabytes }
  do_not_validate_attachment_file_type :document

  before_post_process :generate_digest

  attr_accessor :key, :iv

  private

  def generate_digest
    sha256 = Digest::SHA256.file document.queued_for_write[:original].path
    self.salt = SecureRandom.hex
    sha256.update salt
    self.digest = sha256.hexdigest
  end
end
