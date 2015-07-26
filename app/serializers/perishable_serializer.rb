class PerishableSerializer < ActiveModel::Serializer
  include ActionView::Helpers::NumberHelper

  attributes :name, :content_type, :size, :digest, :url, :download_url

  def name
    object.document_file_name
  end

  def content_type
    object.document_content_type
  end

  def size
    number_to_human_size(object.document_file_size)
  end

  def url
    perishable_url id: object.digest
  end
  
  def download_url
    perishable_download_url perishable_id: object.digest
  end

  def attributes
    data = super
    if @options[:include_crypto]
      data[:key] = object.key
      data[:iv] = object.iv
    end
    data
  end
end
