require 'paperclip/media_type_spoof_detector'

module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end

Paperclip::Attachment.default_options.merge!(
    storage: :s3,
    s3_credentials: {
        bucket: "perish-#{Rails.env}",
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    },
    s3_permissions: :private,
    path: '/:class/:attachment/:id/:style_:filename',
)

Paperclip.interpolates :digest do |attachment, style|
  attachment.instance.digest
end
