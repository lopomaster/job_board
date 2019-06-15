class ApplicationSerializer < ActiveModel::Serializer
  include SimpleEnum::ViewHelpers


  def type
    self.object.class.to_s
  end

end

