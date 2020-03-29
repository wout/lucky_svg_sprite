module LuckySvgSprite::Mixins::Icon
  def class_name
    "svg-icon svg-#{set}-icon svg-#{set}-#{name}-icon"
  end

  def name
    name_part(-1)
  end

  def set
    name_part(-2)
  end

  private def name_part(offset : Int32)
    {{@type.id.split("::")}}[offset].underscore.gsub(/_/, "-")
  end
end
