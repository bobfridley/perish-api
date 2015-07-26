module Paperclip
  module Validators
    module HelperMethods
      def validates_media_type_spoof_detection(*attr_names)
        options = _merge_attributes(attr_names)
        # Commenting out this line so it doesn't run the validator after
        # post processing, because it will always fail since every file is
        # converted to a binary file through encryption.
        # validates_with MediaTypeSpoofDetectionValidator, options.dup
        validate_before_processing MediaTypeSpoofDetectionValidator, options.dup
      end
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
