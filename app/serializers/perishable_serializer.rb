class PerishableSerializer < ActiveModel::Serializer
  attributes :digest

  def attributes
    data = super
    if @options[:include_crypto]
      data[:key] = object.key
      data[:iv] = object.iv
    end
    data
  end
end
