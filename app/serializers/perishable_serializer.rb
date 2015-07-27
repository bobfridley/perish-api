class PerishableSerializer < ActiveModel::Serializer
  include ActionView::Helpers::NumberHelper

  attributes :name, :content_type, :size, :digest

  def name
    object.document_file_name
  end

  def content_type
    object.document_content_type
  end

  def size
    number_to_human_size(object.document_file_size)
  end

  def attributes
    data = super
    if @options[:include_crypto]
      data[:key] = object.key
      data[:iv] = object.iv
    end
    if @options[:include_urls]
      data[:url] = perishable_url id: object.digest
      data[:download_url] = perishable_download_url perishable_id: object.digest
    end
    data
  end
end
